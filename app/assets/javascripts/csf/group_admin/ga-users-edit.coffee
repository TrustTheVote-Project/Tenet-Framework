$ ->
  return unless $("body#ga-users-edit")[0]?

  $("#user_password").pwstrength
    common:
      minChar: 8
      usernameField: '#username'

    rules:
      activated:
        wordTwoCharacterClasses: true

    ui:
      showVerdictsInsideProgressBar: true
      container: '#user_password_viewports'
      viewports:
        progress: '.pr'
