# frozen_string_literal: true

class CreateProductAttributes < ActiveRecord::Migration[7.1]
  def change
    create_table :product_attributes do |t|
      t.belongs_to :product_attributable, polymorphic: true, index: true
      t.belongs_to :manufacturer
      t.belongs_to :trade_mark
      t.string :title
      t.string :slug, null: false
      t.integer :price_cents, null: false
      t.boolean :drop_shipping_available, null: false, default: false
      t.integer :whearhouse_count, null: false, default: 0
      t.timestamps
    end
    add_index :product_attributes, :slug, unique: true
  end
end
