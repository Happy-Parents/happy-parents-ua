# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.3.2'

gem 'rails', '~> 7.1.5'

gem 'activeadmin', '~> 3.2'
gem 'activeadmin_json_editor', '~> 0.0.10'
gem 'bcrypt', '~> 3.1.7'
gem 'devise', '~> 4.9'
gem 'devise-i18n', '~> 1.12'
gem 'mobility', '~> 1.2', '>= 1.2.9'
gem 'mobility-ransack', '~> 1.2', '>= 1.2.2'
gem 'money-rails', '~> 1.15'
gem 'pagy', '~> 8.6', '>= 8.6.1'
gem 'pg', '~> 1.5'
gem 'puma', '>= 5.0'
gem 'pundit', '~> 2.3', '>= 2.3.1'
gem 'rails-controller-testing', '~> 1.0', '>= 1.0.5'
gem 'rails-i18n', '~> 7.0', '>= 7.0.9'
gem 'sidekiq', '~> 7.2'
gem 'tzinfo-data', platforms: %i[windows jruby]

# ASSETS
# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'
# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'importmap-rails'
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
# [DEVISE] Please review the [changelog] and [upgrade guide] for more info on Hotwire / Turbo integration.
# [changelog] https://github.com/heartcombo/devise/blob/main/CHANGELOG.md
#   [upgrade guide] https://github.com/heartcombo/devise/wiki/How-To:-Upgrade-to-Devise-4.9.0-%5BHotwire-Turbo-integration%5D
gem 'turbo-rails'
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'bootstrap', '~> 5.3.3'
gem 'sass-rails', '~> 6.0'
gem 'stimulus-rails'

# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

gem 'aws-sdk-s3', '~> 1.167', require: false
gem 'image_processing', '~> 1.13'

group :development, :test do
  gem 'awesome_print', '~> 1.9', '>= 1.9.2'
  gem 'brakeman', '~> 6.1', '>= 6.1.2'
  gem 'bullet', '~> 7.1', '>= 7.1.6'
  gem 'bundler-audit', '~> 0.9.1'
  gem 'database_cleaner-active_record', '~> 2.2'
  gem 'factory_bot_rails', '~> 6.4', '>= 6.4.3'
  gem 'ffaker', '~> 2.23'
  gem 'reek', '~> 6.3'
  gem 'rspec-rails', '~> 7.0'
  gem 'rubocop', '~> 1.64'
  gem 'rubocop-factory_bot', '~> 2.26'
  gem 'rubocop-faker', '~> 1.1'
  gem 'rubocop-performance', '~> 1.21'
  gem 'rubocop-rails', '~> 2.25'
  gem 'rubocop-rspec', '~> 3.0'
end

group :test do
  gem 'fuubar', '~> 2.5', '>= 2.5.1'
  gem 'pundit-matchers', '~> 3.1', '>= 3.1.2'
  gem 'shoulda-matchers', '~> 6.2'
end

group :development do
  gem 'annotate', '~> 3.2'
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'overcommit', '~> 0.63.0'
  gem 'web-console'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"

  gem 'error_highlight', '>= 0.4.0', platforms: [:ruby]
end
