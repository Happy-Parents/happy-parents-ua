# frozen_string_literal: true

class CreateManufacturers < ActiveRecord::Migration[7.1]
  def change
    create_table :manufacturers do |t|
      t.belongs_to :country
      t.string :name, null: false
      t.timestamps
    end
    add_index :manufacturers, :name, unique: true
  end
end
