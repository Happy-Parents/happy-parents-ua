# frozen_string_literal: true

# == Schema Information
#
# Table name: book_categories
#
#  id         :bigint           not null, primary key
#  slug       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_book_categories_on_slug  (slug) UNIQUE
#
class BookCategory < ApplicationRecord
  include RanSackableAttributable
  extend Mobility

  translates :name, type: :string

  has_and_belongs_to_many :books

  validates :slug, presence: true, uniqueness: { case_sensitive: false }
  # TODO: add uniqueness validation
  validates :name_uk, :name_ru, presence: true

  # Method to generate ransacker for translated attributes
  def self.translation_ransacker(attribute, locale)
    ransacker attribute do
      Arel.sql(
        'COALESCE((SELECT value FROM mobility_string_translations ' \
        "WHERE mobility_string_translations.translatable_type = 'BookCategory' " \
        'AND mobility_string_translations.translatable_id = book_categories.id ' \
        "AND mobility_string_translations.key = 'name' " \
        "AND mobility_string_translations.locale = '#{locale}'), '')"
      )
    end
  end

  translation_ransacker :name_uk, 'uk'
  translation_ransacker :name_ru, 'ru'
end
