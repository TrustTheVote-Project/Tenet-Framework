class AdminAdmin::BaseController < ApplicationController

  before_filter :auth

  private

  def auth
    authenticate_or_request_with_http_basic('Admin-admin Console') do |username, password|
      username == CsfConfig['admin']['login']
    end
  end

end
