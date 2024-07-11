# frozen_string_literal: true

class RenameBooksCategoriesToBookCategoriesBooks < ActiveRecord::Migration[7.1]
  def change
    rename_table :books_categories, :book_categories_books
  end
end
