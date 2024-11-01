# frozen_string_literal: true

class RenameTradeMarkReferences < ActiveRecord::Migration[7.1]
  def change
    rename_column :products, :trade_mark_id, :brand_id
  end
end
