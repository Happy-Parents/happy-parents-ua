# frozen_string_literal: true

class CreateCategoriesProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :categories_products do |t|
      t.belongs_to :product
      t.belongs_to :category
    end
  end
end
