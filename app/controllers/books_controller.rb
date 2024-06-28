# frozen_string_literal: true

# Controller for interacting with book entities
class BooksController < ApplicationController
  def show
    @book = Entities::GetForShowPage.call(**show_params)
  end

  private

  def show_params
    {
      entity_class: Book,
      entity_id: params.require(:id),
      policy_class: BookPolicy,
      user: current_admin
    }
  end
end
