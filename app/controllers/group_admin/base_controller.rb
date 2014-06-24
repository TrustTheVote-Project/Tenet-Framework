class GroupAdmin::BaseController < ApplicationController

  before_filter :require_admin_acc
  
end
