# frozen_string_literal: true

Mobility.configure do
  # PLUGINS
  plugins do
    backend :key_value
    active_record
    reader
    writer
  end
end
