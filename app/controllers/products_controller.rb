# frozen_string_literal: true

# Responsible for interacting Product entity
class ProductsController < ApplicationController
  def show
    @product = Resources::Publishable::GetForShowPage.call(**show_params)
  end

  private

  def show_params
    {
      entity_class: Product,
      entity_slug: params.require(:slug),
      policy_class: ProductPolicy,
      user: current_admin
    }
  end
end
