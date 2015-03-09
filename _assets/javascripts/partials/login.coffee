$(role('login')).click ->
  $(role('login-window')).show()

$(role('login-close')).click ->
  $(role('login-window')).hide()
