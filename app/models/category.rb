# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  slug       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_categories_on_slug  (slug) UNIQUE
#
class Category < ApplicationRecord
  extend Mobility

  translates :name, type: :string

  has_and_belongs_to_many :books

  validates :slug, presence: true, uniqueness: { case_sensitive: false }
end
