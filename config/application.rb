# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AnspointsApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # These timezone settings break RailsAdmin but work great for everything else
    # config.time_zone = "Central Time (US & Canada)"
    # config.active_record.default_timezone = :local
    # config.active_record.time_zone_aware_attributes = false

    # config.eager_load_paths << Rails.root.join("extras")
  end
end
