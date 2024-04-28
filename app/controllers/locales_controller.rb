# frozen_string_literal: true

# Responsible for locale management
class LocalesController < ApplicationController
  def create
    session[:locale] = locale_params
    redirect_back(fallback_location: '/')
  end

  private

  def locale_params
    params.require(:locale)
  end
end
