class AdminAdmin::BaseController < ApplicationController

  before_filter :auth, unless: -> { Rails.env.test? }
  layout "admin"

  def admin_admin?
    !!session[:admin_admin]
  end
  helper_method :admin_admin?

  private

  def auth
    if !session[:admin_admin]
      redirect_to :admin_admin_login, notice: I18n.t('admin_admin.please_login')
    end
  end

end
