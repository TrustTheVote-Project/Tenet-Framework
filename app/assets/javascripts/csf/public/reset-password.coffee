$ ->
  return unless $("body#reset-password, body#init-password")[0]?

  $("#user_password").pwstrength
    ui:
      showVerdictsInsideProgressBar: true
      container: '#user_password_viewports'
      viewports:
        progress: '.pr'
