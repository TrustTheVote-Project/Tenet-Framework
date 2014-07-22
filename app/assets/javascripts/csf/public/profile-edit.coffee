$ ->
  return unless $("body#profile-edit")[0]?

  $("#profile_password").pwstrength
    ui:
      showVerdictsInsideProgressBar: true
      container: '#user_password_viewports'
      viewports:
        progress: '.pr'
