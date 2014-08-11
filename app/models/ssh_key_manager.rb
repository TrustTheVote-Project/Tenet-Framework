class SshKeyManager

  def self.set(user_id, key)
    res = `#{cmd} set #{user_id} "#{sanitize_key(key)}" 2>&1`
    Rails.logger.debug "Setting SSH key:\nUser ID: #{user_id}\nSSH Key: '#{key}'\nResult: #{res}"
  end

  def self.del(user_id)
    res = `#{cmd} del #{user_id} 2>&1`
    Rails.logger.debug "Deleting SSH key:\nUser ID: #{user_id}\nResult: #{res}"
  end

  private

  def self.cmd
    "sudo -u otp #{Rails.root}/scripts/otp-keys"
  end

  def self.sanitize_key(key)
    key.to_s.gsub('"', '')
  end

end
