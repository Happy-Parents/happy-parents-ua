# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :inventory_number, null: false, index: { unique: true }
      t.belongs_to :manufacturer
      t.integer :price_cents, null: false
      t.string :name
      t.string :slug, null: false, index: { unique: true }
      t.integer :whearhouse_count, null: false
      t.boolean :published, null: false, default: false
      t.boolean :drop_shipping_available, null: false, default: false
      t.timestamps
    end
  end
end
