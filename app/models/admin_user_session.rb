class AdminUserSession < Struct.new(:login, :password, :remember_me)

  def authenticates?
    self.login == CsfConfig['admin']['login'] && password_matches?(self.password)
  end

  private

  def password_matches?(password)
    salt = CsfSettings.admin_salt || ''
    encp = CsfSettings.admin_crypted_password || ''

    cp = Sorcery::CryptoProviders::SHA1
    cp.join_token = ''
    cp.stretches  = 1

    cp.matches? encp, password, salt
  end

end
