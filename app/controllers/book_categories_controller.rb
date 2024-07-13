# frozen_string_literal: true

# Controller for interacting with categories of book products
class BookCategoriesController < ApplicationController
  def index
    @pagy, @book_categories = pagy(BookCategory.all)
  end

  def show
    @book_category = Resources::BookCategories::GetForShowPage.call(**show_params)
  end

  private

  def show_params
    {
      slug: params.require(:slug),
      user: current_admin
    }
  end
end
