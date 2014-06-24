class UserSessionsController < ApplicationController

  def new
    @user_session = UserSession.new
    @organizations = []
  end

  def create
    @user_session = UserSession.new(us[:state_id], us[:account_id], us[:type], us[:login], us[:password], us[:remember_me])

    # check that state + account + user tripple exists
    @state = State.find(@user_session.state_id)
    account = @state.accounts.find(@user_session.account_id)
    u = account.users.find_by!(login: @user_session.login)

    # disallow logging admins as users and vice versa
    if u.admin? ? @user_session.type != 'admin' : @user_session.type != 'user'
      raise ActiveRecord::RecordNotFound
    end

    # verify credentials
    user = login(@user_session.login, @user_session.password)

    raise ActiveRecord::RecordNotFound unless user

    if user.admin?
      redirect_to :group_admin_dashboard, notice: I18n.t('.successful_login')
    else
      redirect_to CsfConfig['urls']['user_dashboard'], notice: I18n.t('.successful_login')
    end
  rescue ActiveRecord::RecordNotFound
    flash.now[:alert] = I18n.t('.user_not_found')

    gon.organizations = @state.accounts.map { |a| { id: a.id.to_s, name: a.name } }
    gon.stateId       = @user_session.state_id
    gon.accountId     = @user_session.account_id
    gon.type          = @user_session.type
    gon.login         = @user_session.login

    render :new
  end

  private

  def us
    @us ||= params[:user_session].permit(:state_id, :account_id, :type, :login, :password, :remember_me)
  end

  def setup_gon
    super

    %w( required ).each do |k|
      gon.l[k] = I18n.t("validations.#{k}")
    end

    gon.organizationsInStateUrl = organizations_in_state_path
  end

end
