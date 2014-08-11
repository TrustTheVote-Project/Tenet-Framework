require 'sshkey'

class SshKeyValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return true if SSHKey.valid_ssh_public_key?(value)

    record.errors[attribute] << (options[:message] || "is not a valid public key.")
  end
end
