# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id                      :bigint           not null, primary key
#  drop_shipping_available :boolean          default(FALSE), not null
#  inventory_number        :string           not null
#  name                    :string
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
#  index_products_on_inventory_number  (inventory_number) UNIQUE
#  index_products_on_manufacturer_id   (manufacturer_id)
#  index_products_on_slug              (slug) UNIQUE
#
class Product < ApplicationRecord
  include RanSackableAttributable
  extend Mobility

  belongs_to :manufacturer, optional: true
  has_many :books, dependent: :destroy

  translates :name, ransack: false, type: :string
  monetize :price_cents

  # TODO: add uniqueness validation for name_uk & name_ru
  validates :name_uk,
            :name_ru,
            presence: true

  # TODO: add slug regex validation
  validates :slug,
            :inventory_number,
            presence: true,
            uniqueness: { case_sensitive: false }

  validates :price_cents, presence: true, numericality: { greater_than: 0 }
  validates :whearhouse_count, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
