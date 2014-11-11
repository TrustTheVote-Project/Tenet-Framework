class GroupAdmin::UsersController < GroupAdmin::BaseController

  # Renders active users
  def index
    @users = current_account.users.users_only.active.order("first_name, last_name")
  end

  # Renders suspended users
  def suspended
    @showing_suspended = true
    @users = current_account.users.users_only.suspended.order("first_name, last_name")
    render :index
  end

  # Suspends the user
  def suspend
    user = current_account.users.users_only.find(params[:id])
    user.suspend!
    redirect_to :back, notice: t(".success")
  rescue ActiveRecord::RecordNotFound
    redirect_to :back
  end

  # Unsuspends the user
  def unsuspend
    user = current_account.users.users_only.find(params[:id])
    user.unsuspend!
    redirect_to :back, notice: t(".success")
  rescue ActiveRecord::RecordNotFound
    redirect_to :back
  end

  # Renders new user form
  def new
    @user = User.new
  end

  # Creates new user
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
    @user.setting_password = true if !update_params[:password].blank? || !update_params[:password_confirmation].blank?

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
