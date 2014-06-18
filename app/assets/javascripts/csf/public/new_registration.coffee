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

  # see if we can submit the form
  form.canSubmit = ko.computed ->
    form.errors().length == 0

  # disable form if we can't submit
  $("form").on "submit", (e) ->
    e.preventDefault() unless form.canSubmit()

  # update class and popup of submit button
  submitBtn = $("input[type='submit']")
  updateSubmitBtn = ->
    submitBtn.popover "destroy"
    if form.canSubmit()
      submitBtn.removeClass('grey')
    else
      submitBtn.addClass('grey')
      submitBtn.popover
        html:    true
        content: form.errors().join("<br/>")
        trigger: "hover"

  form.errors.subscribe -> updateSubmitBtn()
  updateSubmitBtn()

  ko.applyBindings form
