# frozen_string_literal: true

class CreateBooksCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :books_categories do |t|
      t.belongs_to :book
      t.belongs_to :category
      t.timestamps
    end
  end
end
