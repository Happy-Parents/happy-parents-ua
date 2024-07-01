# frozen_string_literal: true

# Controller for interacting with book entities
class BooksController < ApplicationController
  def index
    @pagy, @books = pagy(Entities::GetForIndexPage.call(**index_params))
  end

  def show
    @book = Entities::GetForShowPage.call(**show_params)
  end

  private

  def index_params
    {
      entity_class: Book,
      policy_class: BookPolicy,
      user: current_admin
    }
  end

  def show_params
    {
      entity_class: Book,
      entity_slug: params.require(:slug),
      policy_class: BookPolicy,
      user: current_admin
    }
  end
end
