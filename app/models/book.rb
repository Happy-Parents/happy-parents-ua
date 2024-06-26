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

  delegate :drop_shipping_available,
           :inventory_number,
           :name_uk,
           :name_ru,
           :price,
           :published,
           :slug,
           :whearhouse_count,
           :manufacturer,
           to: :product
  # TODO: validate :pages_count numericality
  validates :cover_type,
            :language,
            :pages_count,
            presence: true

  enum cover_type: { hard: 0, soft: 1 }

  enum language: { uk: 0, eng: 1, ru: 2 }

  accepts_nested_attributes_for :product
end
