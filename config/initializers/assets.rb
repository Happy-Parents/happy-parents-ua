# frozen_string_literal: true

Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.precompile += %w[bootstrap.min.js popper.js]

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
