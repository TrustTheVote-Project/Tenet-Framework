class AdminUserSession < Struct.new(:login, :password, :remember_me)

  def authenticates?
    self.login == TenetConfig['admin']['login'] && password_matches?(self.password)
  end

  private

  def password_matches?(password)
    return true if Rails.env.development?

    salt = TenetSettings.admin_salt || ''
    encp = TenetSettings.admin_crypted_password || ''

    cp = Sorcery::CryptoProviders::SHA1
    cp.join_token = ''
    cp.stretches  = 1

    cp.matches? encp, password, salt
  end

end
