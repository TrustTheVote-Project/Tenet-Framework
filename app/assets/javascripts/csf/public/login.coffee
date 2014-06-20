$ ->
  return unless $("body#login")[0]?

  form =
    stateId:       ko.observable()
    accountId:     ko.observable()
    type:          ko.observable()
    login:         ko.observable()
    password:      ko.observable()
    organizations: ko.observableArray([])

  form.pickedState = ko.computed -> filled(form.stateId())
  form.pickedOrganization = ko.computed -> filled(form.accountId())
  form.pickedType = ko.computed -> filled(form.type())

  form.isAdministrator = ko.computed -> form.type() == 'admin'
  form.isUser = ko.computed -> form.type() == 'user'

  form.errors = ko.computed ->
    l = []
    l.push("State #{t('required')}") if blank(form.stateId())
    l.push("Organization #{t('required')}") if blank(form.accountId())
    l.push("User type #{t('required')}") if blank(form.type())
    l.push("Login #{t('required')}") if blank(form.login())
    l.push("Password #{t('required')}") if blank(form.password())
    l

  form.stateId.subscribe (sid) ->
    return if blank(sid)

    $.getJSON gon.organizationsInStateUrl,
      { state_id: sid },
      (data) ->
        form.organizations.removeAll()
        for i in data
          form.organizations.push(i)

    undefined

  bindForm form
