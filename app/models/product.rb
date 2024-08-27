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
#  stock_balance           :integer          not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  brand_id                :bigint
#  manufacturer_id         :bigint
#
# Indexes
#
#  index_products_on_brand_id          (brand_id)
#  index_products_on_inventory_number  (inventory_number) UNIQUE
#  index_products_on_manufacturer_id   (manufacturer_id)
#  index_products_on_slug              (slug) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (brand_id => brands.id)
#

# Reprsents basic product entity to be referenced by different product types
class Product < ApplicationRecord
  include RanSackableAttributable
  extend Mobility

  has_and_belongs_to_many :category
  belongs_to :manufacturer, optional: true
  belongs_to :brand, optional: true

  translates :name, type: :string
  translates :preview, type: :text
  translates :description, type: :text
  monetize :price_cents

  # TODO: revise translated names validations and add tests for create/update,
  # Add validation for preview and description
  # validate :validate_translated_names

  # TODO: add uniqueness validation for translated attributes
  validates :name_uk,
            :name_ru,
            :preview_uk,
            :preview_ru,
            :description_uk,
            :description_ru,
            presence: true

  # TODO: add slug regex validation
  validates :slug,
            :inventory_number,
            presence: true,
            uniqueness: { case_sensitive: false }

  validates :price_cents, presence: true, numericality: { greater_than: 0 }
  validates :stock_balance, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def in_stock?
    drop_shipping_available || stock_balance > 0
  end

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
