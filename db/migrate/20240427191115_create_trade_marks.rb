# frozen_string_literal: true

class CreateTradeMarks < ActiveRecord::Migration[7.1]
  def change
    create_table :trade_marks do |t|
      t.belongs_to :manufacturer
      t.string :name, null: false
      t.timestamps
    end
    add_index :trade_marks, %i[name manufacturer_id], unique: true
  end
end
