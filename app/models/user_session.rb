class UserSession < Struct.new(:state_id, :account_id, :type, :login, :password, :remember_me)
end
