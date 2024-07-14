# frozen_string_literal: true

# == Schema Information
#
# Table name: books
#
#  id          :bigint           not null, primary key
#  authors     :string
#  cover_type  :integer          not null
#  language    :integer          not null
#  pages_count :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  product_id  :bigint
#

# Represents Book specific attributes that together with product entity creates Book entity
class Book < ApplicationRecord
  include RanSackableAttributable

  belongs_to :product
  has_and_belongs_to_many :book_categories

  def self.find_by_slug(slug)
    Book.eager_load(:product).find_by!(product: { slug: })
  end

  delegate :drop_shipping_available,
           :drop_shipping_available?,
           :inventory_number,
           :name,
           :name_uk,
           :name_ru,
           :price,
           :published,
           :published?,
           :slug,
           :stock_balance,
           :manufacturer,
           :in_stock?,
           to: :product
  validates :cover_type,
            :language,
            presence: true

  validates :pages_count, presence: true, numericality: { greater_than: 0 }

  enum cover_type: { hard: 0, soft: 1 }

  enum language: { uk: 0, eng: 1, ru: 2 }

  accepts_nested_attributes_for :product

  scope :published, -> { eager_load(:product).where(product: { published: true }) }
end
