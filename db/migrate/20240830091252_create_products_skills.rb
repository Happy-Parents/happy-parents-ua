# frozen_string_literal: true

class CreateProductsSkills < ActiveRecord::Migration[7.1]
  def change
    create_table :products_skills do |t|
      t.belongs_to :product
      t.belongs_to :skill
    end
  end
end
