# frozen_string_literal: true

class RenameWarehouseCountToStockBalance < ActiveRecord::Migration[7.1]
  def change
    rename_column :products, :whearhouse_count, :stock_balance
  end
end
