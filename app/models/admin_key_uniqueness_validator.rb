require 'sshkey'

class AdminKeyUniquenessValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return true if value.blank? || TenetSettings.admin_public_key != value
    record.errors[attribute] << (options[:message] || I18n.t("errors.messages.admin_key_uniqueness"))
  end
end
