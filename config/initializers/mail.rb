Rails.application.configure do
  opts = {
    host: CsfConfig['email']['host']
  }

  if !(port = CsfConfig['email']['port']).blank?
    opts[:port] = port
  end

  config.action_mailer.default_url_options = opts
end
