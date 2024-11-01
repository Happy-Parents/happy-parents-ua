# frozen_string_literal: true

class AddAgeRangeToProduct < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :age_range, :integer
  end
end
