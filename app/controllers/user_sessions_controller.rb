class UserSessionsController < ApplicationController

  def new
    @user_session = UserSession.new
    @organizations = []
  end

  def create
    @user_session = UserSession.new(us[:state_id], us[:account_id], us[:type], us[:login], us[:password], us[:remember_me])

    # check that state + account + user tripple exists
    @state = State.find(@user_session.state_id)

    # disallow suspended organizations
    account = @state.accounts.find(@user_session.account_id)
    if account.suspended?
      redirect_to :login, alert: t(".organization_suspended")
      return
    end

    # disallow suspended accounts
    u = account.users.find_by!(login: @user_session.login)
    if u.suspended?
      redirect_to :login, alert: t(".user_suspended")
      return
    end

    # disallow logging admins as users and vice versa
    if u.admin? ? @user_session.type != 'admin' : @user_session.type != 'user'
      raise ActiveRecord::RecordNotFound
    end

    # verify credentials
    user = Rails.env.production? ? login(@user_session.login, @user_session.password) : u
    raise ActiveRecord::RecordNotFound unless user

    if user.admin?
      # clear OTP once logged in
      user.clear_password! unless Rails.env.development?

      redirect_to :group_admin_dashboard, notice: t('.successful_login')
    else
      redirect_to TenetConfig['urls']['user_dashboard'], notice: t('.successful_login')
    end
  rescue ActiveRecord::RecordNotFound
    flash.now[:alert] = t('.user_not_found')

    gon.organizations = @state.accounts.map { |a| { id: a.id.to_s, name: a.name } }
    gon.stateId       = @user_session.state_id
    gon.accountId     = @user_session.account_id
    gon.type          = @user_session.type
    gon.login         = @user_session.login

    render :new
  end

  def destroy
    logout
    redirect_to :root, notice: t(".successful_logout")
  end

  private

  def us
    @us ||= params[:user_session].permit(:state_id, :account_id, :type, :login, :password, :remember_me)
  end

  def setup_gon
    super

    %w( required ).each do |k|
      gon.l[k] = t("validations.#{k}")
    end

    gon.type = params[:user_session].try(:[], :type)
    gon.organizationsInStateUrl = organizations_in_state_path
    gon.user_id_placeholder = I18n.t('user_sessions.new.user_id_placeholder')
    gon.password_placeholder = I18n.t('user_sessions.new.password_placeholder')
  end
end
