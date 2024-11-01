# frozen_string_literal: true

class AddMeterialReferenceToProduct < ActiveRecord::Migration[7.1]
  def change
    add_reference :products, :material, foreign_key: true
  end
end
