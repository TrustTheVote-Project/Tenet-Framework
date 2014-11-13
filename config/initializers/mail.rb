Rails.application.configure do
  opts = {
    host: TenetConfig['email']['host']
  }

  if !(port = TenetConfig['email']['port']).blank?
    opts[:port] = port
  end

  config.action_mailer.default_url_options = opts
end
