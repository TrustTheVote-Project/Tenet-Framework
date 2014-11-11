class GroupAdmin::BaseController < ApplicationController

  before_filter :require_admin_acc, unless: -> { Rails.env.test? }

end
