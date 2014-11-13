class AdminAdmin::UserSessionsController < AdminAdmin::BaseController

  skip_before_filter :auth, only: [ :new, :create ]

  # login form for admin-admin
  def new
    @user_session = AdminUserSession.new
  end

  # login admin-admin
  def create
    @user_session = AdminUserSession.new(us[:login], us[:password], true)

    if @user_session.authenticates?
      TenetSettings.clear_admin_password!

      session[:admin_admin] = true
      redirect_to :admin_admin_dashboard, notice: I18n.t('.successful_login')
    else
      session[:admin_admin] = nil
      flash.now[:alert] = I18n.t('.user_not_found')
      render :new
    end
  end

  # logout admin-admin
  def destroy
    session[:admin_admin] = nil
    redirect_to :root, notice: I18n.t('.successful_logout')
  end

  private

  def us
    @us ||= params[:user_session].permit(:login, :password, :remember_me)
  end

end
