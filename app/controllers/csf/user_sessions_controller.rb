require_dependency "csf/application_controller"

module Csf
  class UserSessionsController < Csf::ApplicationController

    def new
      @user_session = UserSession.new
    end

    def create
      @user_session = UserSession.new(us[:state_id], us[:account_id], us[:type], us[:login], us[:password], us[:remember_me])

      # check that state + account + user tripple exists
      state = State.find(@user_session.state_id)
      account = state.accounts.find(@user_session.account_id)
      account.users.find_by!(login: @user_session.login)

      # verify credentials
      user = login(@user_session.login, @user_session.password, @user_session.remember_me)

      raise ActiveRecord::RecordNotFound unless user

      if user.admin?
        redirect_to :admin_dashboard
      else
        redirect_to :user_dashboard
      end
    rescue ActiveRecord::RecordNotFound
      flash.now[:alert] = I18n.t('.user_not_found')
      render :new
    end

    private

    def us
      @us ||= params[:user_session].permit(:state_id, :account_id, :type, :login, :password, :remember_me)
    end

    def setup_gon
      super

      %w( required ).each do |k|
        gon.l[k] = I18n.t("csf.validations.#{k}")
      end

      gon.organizationsInStateUrl = organizations_in_state_path
    end

  end
end
