class GroupAdmin::UsersController < GroupAdmin::BaseController

  def index
    @users = current_account.users.users_only.order("first_name, last_name")
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(new_params)
    @user.account = current_account

    if @user.save
      @user.deliver_reset_password_instructions!
      redirect_to :group_admin_users, notice: t(".success")
    else
      Rails.logger.info @user.valid?
      Rails.logger.info @user.errors.inspect
      render :new
    end
  end

  def edit
    @user = current_account.users.find(params[:id])
  end

  def update
    @user = current_account.users.find(params[:id])
    if @user.update_attributes(update_params)
      redirect_to :group_admin_users, notice: t(".success")
    else
      render :edit
    end
  end

  def destroy
    @user = current_account.users.find(params[:id])
    @user.destroy

    redirect_to :group_admin_users, notice: t(".success")
  end

  private

  def new_params
    params[:user].permit(:email, :first_name, :last_name, :title, :phone, :role)
  end

  def update_params
    params[:user].permit(:email, :first_name, :last_name, :title, :phone, :role, :password, :password_confirmation)
  end

end
