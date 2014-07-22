$ ->
  return unless $("body#ga-users-edit")[0]?

  $("#user_password").pwstrength
    ui:
      showVerdictsInsideProgressBar: true
      container: '#user_password_viewports'
      viewports:
        progress: '.pr'
