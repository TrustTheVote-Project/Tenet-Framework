class Notifications < ActionMailer::Base

  default from: CsfConfig['email']['noreply']

  # new registration request received
  def new_registration_request(req_id)
    @request = RegistrationRequest.find(req_id)
    mail to: CsfConfig['email']['superadmin']
  end

  # reset / initialize password
  def reset_password_email(user)
    base  = "notifications.reset_password_email"
    token = user.reset_password_token

    if user.password_set?
      body    = t("#{base}.body.reset", name: user.first_name, url: reset_password_url(token))
      subject = t("#{base}.subject.reset")
    else
      body    = t("#{base}.body.init", name: user.first_name, url: reset_password_url(token))
      subject = t("#{base}.subject.init")
    end

    mail to: user.email, subject: subject, body: body
  end

  def group_created(user_id)
    user = User.find(user_id)
    body = t("notifications.group_created.body", name: user.first_name, login_url: login_url)
    mail to: user.email, body: body
  end

end
