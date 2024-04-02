# frozen_string_literal: true

if Rails.env.development?
  admin_data = Rails.application.credentials.dig(:db, :admin)

  Admin.create(
    email: admin_data[:email],
    password: admin_data[:password],
    password_confirmation: admin_data[:password]
  )
end
