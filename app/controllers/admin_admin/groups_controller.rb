class AdminAdmin::GroupsController < AdminAdmin::BaseController

  # Renders the list of active organizations
  def index
    @accounts = Account.active.order("name")
  end

  # Renders the list of suspended organizations
  def suspended
    @accounts = Account.suspended.order("name")
    @showing_suspended = true
    render :index
  end

  # Renders organization details
  def show
    @account = Account.find(params[:id])
    @users   = @account.users.active
  end

  # Renders organization details with suspended users
  def suspended_users
    @showing_suspended_users = true
    @account = Account.find(params[:id])
    @users   = @account.users.suspended
    render :show
  end

  # Suspends the account
  def suspend
    acc = Account.find(params[:id])
    acc.suspend!
    redirect_to :back, notice: t(".success")
  rescue ActiveRecord::RecordNotFound
    redirect_to :back
  end

  # Unsuspends the account
  def unsuspend
    acc = Account.find(params[:id])
    acc.unsuspend!
    redirect_to :back, notice: t(".success")
  rescue ActiveRecord::RecordNotFound
    redirect_to :back
  end

  # Shows new organization form
  def new
    if req
      @account = Account.new_from_request(req)
    else
      @account = Account.new
      @account.users << u = User.new
      u.admin = true
    end
  end

  # Creates the organization
  def create
    @account = Account.new(ap)
    if @account.save
      req.archive! if req

      SshKeyManager.regenerate_otp_authorized_keys

      # notify group users that their group has been approved
      @account.users.each do |u|
        # Notifications.delay.group_created(u.id)
        Notifications.group_created(u.id).deliver
      end

      account_after_create_hook(@account)

      redirect_to admin_admin_group_path(@account), notice: t(".success")
    else
      render :new
    end
  end

  # Destroys the organization
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
