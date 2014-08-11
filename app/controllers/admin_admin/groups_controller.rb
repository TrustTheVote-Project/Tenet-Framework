class AdminAdmin::GroupsController < AdminAdmin::BaseController

  def index
    @accounts = Account.order("name")
  end

  def show
    @account = Account.find(params[:id])
  end

  def new
    if req
      @account = Account.new_from_request(req)
    else
      @account = Account.new
      @account.users << u = User.new
      u.admin = true
    end
  end

  def create
    @account = Account.new(ap)
    if @account.save
      req.archive! if req

      # notify group users that their group has been approved
      @account.users.each do |u|
        if key = u.ssh_public_key
          SshKeyManager.set(u.id, key)
        end

        # Notifications.delay.group_created(u.id)
        Notifications.group_created(u.id).deliver
      end

      account_after_create_hook(@account)

      redirect_to admin_admin_group_path(@account), notice: t(".success")
    else
      render :new
    end
  end

  def destroy
    @account = Account.find(params[:id])
    @account.destroy

    redirect_to :admin_admin_groups, notice: t(".success")
  end

  private

  def ap
    params[:account].permit(:name, :state_id, users_attributes: [ :admin, :login, :first_name, :last_name, :title, :phone, :email, :ssh_public_key ])
  end

  def req
    @req ||= begin
      if !(reqid = params[:request]).blank?
        req = RegistrationRequest.find(reqid)
      end
    end
  end

  def account_after_create_hook(account)
    cl = CsfConfig['account_hooks_class_name']
    mn = CsfConfig['account_after_create_method_name']

    if cl && mn && cl.constantize.respond_to?(mn)
      cl.constantize.send(mn, account)
    end
  end

end
