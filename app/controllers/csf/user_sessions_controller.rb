require_dependency "csf/application_controller"

module Csf
  class UserSessionsController < Csf::ApplicationController

    def new
      @user_session = UserSession.new
    end

    def create
      @user_session = UserSession.new(us[:state_id], us[:account_id], us[:type], us[:login], us[:password], us[:remember_me])

      flash.now[:alert] = "Test"
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
