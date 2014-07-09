class AdminUserSession < Struct.new(:login, :password, :remember_me)

  def authenticates?
    self.login == CsfConfig['admin']['login'] && self.password == current_password
  end

  private

  def current_password
    # will be replaced with the OTP
    '0000'
  end

end
