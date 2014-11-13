$ ->
  return unless $("body#login")[0]?

  form =
    stateId:       ko.observable(gon.stateId)
    accountId:     ko.observable(gon.accountId)
    type:          ko.observable(gon.type || 'user')
    login:         ko.observable(gon.login)
    password:      ko.observable()
    organizations: ko.observableArray(gon.organizations)

  $('.nav-tabs a').on 'click', (e) ->
    e.preventDefault()
    form.type($(this).data('type'))
    $(this).tab('show')

  form.pickedState = ko.computed -> filled(form.stateId())
  form.pickedOrganization = ko.computed -> filled(form.accountId())

  form.isAdministrator = ko.computed -> form.type() == 'admin'
  form.isUser = ko.computed -> form.type() == 'user'

  form.useridPlaceholder = ko.computed -> gon.user_id_placeholder[form.type()]
  form.passwordPlaceholder = ko.computed -> gon.password_placeholder[form.type()]

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
