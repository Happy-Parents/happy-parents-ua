# frozen_string_literal: true

# Main application controller to be inherited from with all shared behaviour
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_locale

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
end
