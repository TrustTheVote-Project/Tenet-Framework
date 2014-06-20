$ ->
  return unless $("#registration_request_new")[0]?

  form =
    organizationName: ko.observable()
    state:            ko.observable()
    website:          ko.observable()
    adminName:        ko.observable()
    adminTitle:       ko.observable()
    adminEmail:       ko.observable()
    adminPhone:       ko.observable()

  form.errors = ko.computed ->
    l = []
    l.push("Organization name #{t('required')}") if blank(form.organizationName())
    l.push("State #{t('required')}") if blank(form.state())
    l.push(t('invalid_website')) unless url(form.website())
    l.push("Your name #{t('required')}") if blank(form.adminName())
    l.push("Your title #{t('required')}") if blank(form.adminTitle())
    l.push(t('invalid_email')) unless email(form.adminEmail())
    l.push(t('invalid_phone')) unless phone(form.adminPhone())
    l

  bindForm form
