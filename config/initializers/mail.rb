Rails.application.configure do
  opts = {
    host: TenetConfig['email'].try(:[], 'host') || 'localhost'
  }

  if !(port = TenetConfig['email'].try(:[], 'port')).blank?
    opts[:port] = port
  end

  config.action_mailer.default_url_options = opts
end
