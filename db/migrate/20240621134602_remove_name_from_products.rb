# frozen_string_literal: true

class RemoveNameFromProducts < ActiveRecord::Migration[7.1]
  def change
    remove_column :products, :name, :string
  end
end
