# frozen_string_literal: true

class AddTradeMarkReferenceToProduct < ActiveRecord::Migration[7.1]
  def change
    add_reference :products, :trade_mark, foreign_key: true
  end
end
