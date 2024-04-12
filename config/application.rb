# frozen_string_literal: true

require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_mailbox/engine'
require 'action_text/engine'
require 'action_view/railtie'
require 'action_cable/engine'
require 'sprockets/railtie'
require 'rails/test_unit/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module HappyParentsUa
  class Application < Rails::Application
    config.load_defaults 7.0
    config.time_zone = 'Kyiv'
    config.i18n.available_locales = %i[uk ru]
    config.i18n.default_locale = :uk
    config.i18n.load_path += Dir[Rails.root.join('config/locales/**/*.yml')]

    # config.eager_load_paths << Rails.root.join("extras")
    config.generators.test_framework = :rspec
  end
end
