# frozen_string_literal: true

class ChangeBookCategoriesBooksColumnNames < ActiveRecord::Migration[7.1]
  def change
    rename_column :book_categories_books, :category_id, :book_category_id
  end
end
