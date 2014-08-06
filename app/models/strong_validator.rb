class StrongValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    return if strong?(value, record.login)

    record.errors[attribute] << (options[:message] || I18n.t("errors.messages.strong"))
  end

  private

  def strong?(password, username)
    return false if password.size < 8

    variety = 0
    variety += 1 if password =~ /[A-Z]/
    variety += 1 if password =~ /[a-z]/
    variety += 1 if password =~ /[0-9]/
    return false if variety < 2 || password =~ /#{username}/

    return true
  end

end
