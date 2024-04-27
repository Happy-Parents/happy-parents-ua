# frozen_string_literal: true

Mobility.configure do
  # PLUGINS
  plugins do
    backend :key_value
    active_record
    ransack
    locale_accessors
    reader
    writer
  end
end
