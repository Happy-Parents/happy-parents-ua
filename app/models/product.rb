# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id                      :bigint           not null, primary key
#  drop_shipping_available :boolean          default(FALSE), not null
#  inventory_number        :string           not null
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

# Reprsents basic product entity to be referenced by different product types
class Product < ApplicationRecord
  include RanSackableAttributable
  extend Mobility

  belongs_to :manufacturer, optional: true
  has_many :books, dependent: :destroy

  translates :name, type: :string
  monetize :price_cents

  # TODO: revise translated names validations and add tests for create/update seperate/botch
  # validate :validate_translated_names

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

  # TODO: verify and debug whether next line is needed
  accepts_nested_attributes_for :books, allow_destroy: true

  private

  def validate_translated_names
    I18n.available_locales.each do |locale|
      I18n.with_locale(locale) do
        validate_name_presence
        validate_name_uniqueness(locale)
      end
    end
  end

  def validate_name_presence
    errors.add(:name, :blank, message: "can't be blank") if name.blank?
  end

  def validate_name_uniqueness(locale)
    if Mobility::Backends::ActiveRecord::KeyValue::StringTranslation.exists?(
      translatable_type: self.class.name,
      locale: locale.to_s,
      key: 'name',
      value: name
    )

      errors.add(:"name_#{locale}", :uniqueness, message: 'must be unique')
    end
  end
end
