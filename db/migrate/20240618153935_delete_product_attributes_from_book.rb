# frozen_string_literal: true

class DeleteProductAttributesFromBook < ActiveRecord::Migration[7.1]
  def change
    remove_index :books, :slug if index_exists?(:books, :slug)

    change_table :books, bulk: true do |t|
      t.remove :slug, type: :string
      t.remove :name, type: :string
      t.remove :price_cents, type: :integer
      t.remove :drop_shipping_available, type: :boolean
      t.remove :published, type: :boolean
      t.remove :whearhouse_count, type: :integer
      t.remove :manufacturer_id, type: :bigint
    end
  end
end
