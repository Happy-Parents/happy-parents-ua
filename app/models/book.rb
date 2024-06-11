# frozen_string_literal: true

# == Schema Information
#
# Table name: books
#
#  id                      :bigint           not null, primary key
#  authors                 :string
#  cover_type              :integer          not null
#  drop_shipping_available :boolean          default(FALSE), not null
#  language                :integer          not null
#  name                    :string
#  pages_count             :integer          not null
#  price_cents             :integer          not null
#  published               :boolean          default(FALSE), not null
#  slug                    :string           not null
#  whearhouse_count        :integer          not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  manufacturer_id         :bigint
#
# Indexes
#
#  index_books_on_manufacturer_id  (manufacturer_id)
#  index_books_on_slug             (slug) UNIQUE
#
class Book < ApplicationRecord
  include RanSackableAttributable
  extend Mobility

  belongs_to :manufacturer, optional: true

  translates :name, type: :string
  monetize :price_cents

  # TODO: add uniqueness validation for name_uk & name_ru
  validates :name_uk,
            :name_ru,
            :cover_type,
            :language,
            :pages_count,
            presence: true

  # TODO: add slug regex validation
  validates :slug, presence: true,
                   uniqueness: { case_sensitive: false }

  validates :price_cents, presence: true, numericality: { greater_than: 0 }
  validates :whearhouse_count, presence: true, numericality: { greater_than_or_equal_to: 0 }

  enum cover_type: { hard: 0, soft: 1 }

  enum language: { uk: 0, eng: 1, ru: 2 }
end
