# frozen_string_literal: true

# Controller for interacting with categories of book products
class BookCategoriesController < ApplicationController
  def show
    # TODO: select only published books
    @book_category = BookCategory.preload(:books).find_by!(slug: show_params)
  end

  private

  def show_params
    params.require(:slug)
  end
end
