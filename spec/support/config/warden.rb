# frozen_string_literal: true

RSpec.configure do |config|
  config.include Warden::Test::Helpers

  config.after do
    Warden.test_reset!
  end
end
