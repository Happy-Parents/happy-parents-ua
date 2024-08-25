# frozen_string_literal: true

# Main application controller to be inherited from with all shared behaviour
class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :set_locale

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  private

  def set_locale
    I18n.locale = detected_locale
  end

  def detected_locale
    default_locale = I18n.default_locale
    if request.path == '/admin'
      default_locale
    else
      session[:locale] || default_locale
    end
  end

  def admin_panel_request?
    request.fullpath.starts_with?('/admin')
  end

  def render_not_found(exception)
    render html: { error: exception.message }, status: :not_found
  end
end
