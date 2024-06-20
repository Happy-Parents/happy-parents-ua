# frozen_string_literal: true

class AddProductReferenceToBook < ActiveRecord::Migration[7.1]
  def change
    add_column :books, :product_id, :bigint
  end
end
