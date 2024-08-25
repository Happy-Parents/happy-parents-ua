# frozen_string_literal: true

class DropTableBooks < ActiveRecord::Migration[7.1]
  def change
    drop_table :books do |t|
      t.integer 'cover_type', null: false
      t.integer 'language', null: false
      t.integer 'pages_count', null: false
      t.string 'authors'
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.bigint 'product_id'
    end
  end
end
