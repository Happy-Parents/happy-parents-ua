# frozen_string_literal: true

class AddSpecificationsToProduct < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :specifications, :jsonb, null: false, default: {}
  end
end
