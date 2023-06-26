Sentry.init do |config|
  config.dsn = 'https://b57a9952dc8f40cca738a360e9f520d9@o4505423426879488.ingest.sentry.io/4505423436972032'
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]

  # Set traces_sample_rate to 1.0 to capture 100%
  # of transactions for performance monitoring.
  # We recommend adjusting this value in production.
  config.traces_sample_rate = 1.0
  # or
  config.traces_sampler = lambda do |context|
    true
  end
end
