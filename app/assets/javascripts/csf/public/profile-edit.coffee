$ ->
  return unless $("body#profile-edit")[0]?

  $("#profile_password").pwstrength
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
