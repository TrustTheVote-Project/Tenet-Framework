$ ->
  return unless $("body#reset-password, body#init-password")[0]?

  $("#user_password").pwstrength
    common:
      minChar: 8

    rules:
      activated:
        wordTwoCharacterClasses: true

    ui:
      showVerdictsInsideProgressBar: true
      container: '#user_password_viewports'
      viewports:
        progress: '.pr'
