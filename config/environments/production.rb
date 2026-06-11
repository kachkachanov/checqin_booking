require "active_support/core_ext/integer/time"

Rails.application.configure do
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true
  config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"].present? || ENV["RENDER"].present?
  config.active_storage.service = :local
  config.log_level = :info
  config.log_tags = [ :request_id ]
  config.action_mailer.perform_caching = false
  config.action_mailer.raise_delivery_errors = false

  if ENV['GMAIL_USER'].present?
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address: 'smtp.gmail.com',
      port: 587,
      user_name: ENV.fetch('GMAIL_USER'),
      password: ENV.fetch('GMAIL_PASSWORD'),
      authentication: :plain,
      enable_starttls_auto: true
    }
  else
    config.action_mailer.delivery_method = :test
  end

  config.action_mailer.default_url_options = {
    host: ENV.fetch("APP_HOST", "checqin-booking.onrender.com"),
    protocol: ENV.fetch("APP_PROTOCOL", "https")
  }
  config.action_controller.default_url_options = {
    host: ENV.fetch("APP_HOST", "checqin-booking.onrender.com"),
    protocol: ENV.fetch("APP_PROTOCOL", "https")
  }
  config.i18n.fallbacks = true
  config.active_support.report_deprecations = false
  config.log_formatter = ::Logger::Formatter.new

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger = ActiveSupport::TaggedLogging.new(logger)
  end

  config.active_record.dump_schema_after_migration = false
end
