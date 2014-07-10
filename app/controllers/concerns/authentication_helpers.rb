module Concerns::AuthenticationHelpers
  extend ActiveSupport::Concern

  included do
    # returns currently logged in user account, either user or admin
    alias :current_login :current_user

    helper_method :current_account
    helper_method :current_login
    helper_method :current_user_acc
    helper_method :current_admin_acc
    helper_method :group_admin?
  end

  # returns the #Account of currently logged in user, or #nil
  def current_account
    unless defined?(@current_account)
      @current_account = current_user.try(:account)
    end
    @current_account
  end

  # returns #User for currently logged in user, or #nil
  def current_user_acc
    unless defined?(@current_user_acc)
      @current_user_acc = current_login.try(:user?) ? current_login : nil
    end
    @current_user_acc
  end

  # returns #User for currently logged in admin, or #nil
  def current_admin_acc
    unless defined?(@current_admin_acc)
      @current_admin_acc = current_login.try(:admin?) ? current_login : nil
    end
    @current_admin_acc
  end

  # TRUE if currently logged and is group admin
  def group_admin?
    !!current_admin_acc
  end

  # for use in before filter
  def require_user_acc
    handle_not_authenticated if !current_user_acc
  end

  # for use in before_filter
  def require_admin_acc
    handle_not_authenticated if !current_admin_acc
  end

  private

  def handle_not_authenticated
    session[:return_to_url] = request.url if request.get?
    redirect_to :login, alert: I18n.t('.unauthenticated')
  end

end
