require 'open3'

class SshKeyManager

  def self.regenerate_otp_authorized_keys
    exit_status = nil

    Open3.popen3(env, cmd) do |stdin, stdout, stderr, wait_thr|
      stdin.puts "# This file is written by #{Rails.root}/scripts/otp-key"
      stdin.puts "# when called by #{Rails.root}/app/models/ssh_key_manager.rb\n"

      if !(admin_public_key = TenetSettings.admin_public_key).blank?
        stdin.puts "environment=\"TENET_USER_ID=admin\" #{admin_public_key}"
      end

      User.where(admin: true).each do |u|
        next if u.ssh_public_key.blank?
        stdin.puts "environment=\"TENET_USER_ID=#{u.id}\" #{u.ssh_public_key}"
      end

      stdin.close
      stderr.close
      stdout.close

      Rails.logger.debug "Finished writing authenticated_keys"

      exit_status = wait_thr.value.exitstatus
    end

    Rails.logger.debug "Closed streams"

    if exit_status != 0
      Rails.logger.error "Failed to write authorized_keys"

      # TODO failed to generate authorized_keys. report.
    end
  end

  private

  def self.env
    if Rails.env.development? or Rails.env.test?
      keys_file = "#{Rails.root}/tmp/authorized_keys"
      `touch #{keys_file}`
      { "TENET_AUTHORIZED_KEYS_FILE" => keys_file }
    else
      { "TENET_AUTHORIZED_KEYS_FILE" => "/home/#{otp_user}/.ssh/authorized_keys" }
    end
  end

  def self.cmd
    c = "#{Rails.root}/scripts/otp-keys"

    if Rails.env.development? or Rails.env.test?
      c
    else
      "sudo -u #{otp_user} #{c}"
    end
  end

  def self.otp_user
    TenetConfig['otp_user'] || 'otp'
  end
end
