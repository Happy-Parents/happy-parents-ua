# frozen_string_literal: true

class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.belongs_to :manufacturer
      t.string :name
      t.string :slug, null: false, index: { unique: true }
      t.integer :cover_type, null: false
      t.integer :language, null: false
      t.integer :pages_count, null: false
      t.string :authors
      t.integer :price_cents, null: false
      t.integer :whearhouse_count, null: false
      t.boolean :drop_shipping_available, null: false, default: false
      t.boolean :published, null: false, default: false
      t.timestamps
    end
  end
end
