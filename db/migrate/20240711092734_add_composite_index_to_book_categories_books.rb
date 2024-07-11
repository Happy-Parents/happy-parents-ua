# frozen_string_literal: true

class AddCompositeIndexToBookCategoriesBooks < ActiveRecord::Migration[7.1]
  def change
    add_index :book_categories_books,
              %i[book_id book_category_id],
              unique: true,
              name: 'index_book_categories_books_on_book_id_and_category_id'
  end
end
