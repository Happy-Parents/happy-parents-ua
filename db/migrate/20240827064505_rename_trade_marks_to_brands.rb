# frozen_string_literal: true

class RenameTradeMarksToBrands < ActiveRecord::Migration[7.1]
  def change
    rename_table :trade_marks, :brands
  end
end
