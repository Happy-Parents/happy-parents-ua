# frozen_string_literal: true

class DropTableBookCategoriesBooks < ActiveRecord::Migration[7.1]
  def change
    drop_table :book_categories_books do |t|
      t.bigint 'book_id'
      t.bigint 'book_category_id'
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.index ['book_category_id'], name: 'index_book_categories_books_on_book_category_id'
      t.index %w[book_id book_category_id], name: 'index_book_categories_books_on_book_id_and_category_id',
                                            unique: true
      t.index ['book_id'], name: 'index_book_categories_books_on_book_id'
    end
  end
end
