# frozen_string_literal: true

class DropTableBookCategories < ActiveRecord::Migration[7.1]
  def change
    drop_table :book_categories do |t|
      t.string 'slug', null: false
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.index ['slug'], name: 'index_book_categories_on_slug', unique: true
    end
  end
end
