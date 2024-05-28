# frozen_string_literal: true

class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.integer :cover_type, null: false
      t.integer :pages_count, null: false
      t.integer :language, null: false
      t.timestamps
    end
  end
end
