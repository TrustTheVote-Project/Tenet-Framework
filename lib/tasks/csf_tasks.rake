namespace :csf do
  namespace :db do
    desc "Seeds database with data"
    task :seed => :environment do
      supported_types = [ 'state', 'outlying area' ]

      us = Carmen::Country.named('United States')
      us.subregions.each do |s|
        next unless supported_types.include?(s.type)
        State.create_with(name: s.name).find_or_create_by(code: s.code)
      end

      State.create_with(name: '-- Other --').find_or_create_by(code: 'ZZ')
    end
  end

  desc "Sets admin-admin public key"
  task :set_admin_public_key => :environment do
    key = ENV['PUBLIC_KEY']

    require 'sshkey'
    unless SSHKey.valid_ssh_public_key?(key)
      puts "Usage: rake csf:set_admin_public_key PUBLIC_KEY='ssh-... AAAM... name'"
      exit 1
    end

    if (u = User.where(ssh_public_key: key).first).present?
      puts "This public key is used by the group admin (#{u.login} - #{u.full_name}) from #{u.account.name} (#{u.account.state.name})."
      puts "Please choose a different key."
      exit 1
    end

    CsfSettings.admin_public_key = key

    # regenerate authorized_keys
    SshKeyManager.regenerate_otp_authorized_keys
  end
end
