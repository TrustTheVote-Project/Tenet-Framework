$ ->
  return unless $("#aa_groups_new")[0]?

  form =
    firstName: ko.observable()
    lastName:  ko.observable()

  form.fullName = ko.computed ->
    [ form.firstName(), form.lastName() ].join(' ')

  form.sshKeyHelp = ko.computed ->
    name = form.fullName()
    name = gon.administrator if name.match(/^ *$/)
    gon.ssh_key_help.replace('{name}', name)

  setTooltip = ->
    $(".what").tooltip('destroy').attr(title: form.sshKeyHelp()).tooltip(html: true, delay: { hide: 1000 })

  form.sshKeyHelp.subscribe (newVal) -> setTooltip()
  setTooltip()

  ko.applyBindings form
