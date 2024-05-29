# frozen_string_literal: true

# == Schema Information
#
# Table name: product_attributes
#
#  id                        :bigint           not null, primary key
#  drop_shipping_available   :boolean          default(FALSE), not null
#  price_cents               :integer          not null
#  product_attributable_type :string
#  slug                      :string           not null
#  title                     :string
#  whearhouse_count          :integer          default(0), not null
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  manufacturer_id           :bigint
#  product_attributable_id   :bigint
#  trade_mark_id             :bigint
#
# Indexes
#
#  index_product_attributes_on_manufacturer_id       (manufacturer_id)
#  index_product_attributes_on_product_attributable  (product_attributable_type,product_attributable_id)
#  index_product_attributes_on_slug                  (slug) UNIQUE
#  index_product_attributes_on_trade_mark_id         (trade_mark_id)
#
class ProductAttribute < ApplicationRecord
  monetize :price_cents

  belongs_to :product_attributable, polymorphic: true
  belongs_to :manufacturer, optional: true
  belongs_to :trade_mark, optional: true
  validates :price_cents,
            :drop_shipping_available,
            :whearhouse_count,
            presence: true

  validates :slug,
            presence: true,
            uniqueness: true
end
