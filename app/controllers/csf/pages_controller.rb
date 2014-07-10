class Csf::PagesController < ApplicationController

  before_filter :require_login, only: [ :user_dashboard ]

  def landing
  end
  
end
