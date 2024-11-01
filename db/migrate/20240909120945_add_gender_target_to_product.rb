# frozen_string_literal: true

class AddGenderTargetToProduct < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :gender_target, :integer, null: false, default: 0
  end
end
