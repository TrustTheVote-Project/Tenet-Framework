Sidekiq.configure_server do |config|
  config.redis = { size: 2, namespace: "csf" }
end

Sidekiq.configure_client do |config|
  config.redis = { size: 1, namespace: "csf" }
end
