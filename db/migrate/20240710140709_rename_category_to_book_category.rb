# frozen_string_literal: true

class RenameCategoryToBookCategory < ActiveRecord::Migration[7.1]
  def change
    rename_table :categories, :book_categories
  end
end
