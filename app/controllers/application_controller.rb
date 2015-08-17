class ApplicationController < ActionController::Base

  include Concerns::AuthenticationHelpers

  before_filter :set_locale
  before_filter :setup_gon

  def set_locale
    I18n.locale = session[:locale] if session[:locale]
  end

  def setup_gon
    gon.env = Rails.env
    gon.l = {}
  end

end
