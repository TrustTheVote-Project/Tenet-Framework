class ApplicationController < ActionController::Base

  include Concerns::AuthenticationHelpers

  before_filter :setup_gon

  def setup_gon
    gon.env = Rails.env
    gon.l = {}
  end

end
