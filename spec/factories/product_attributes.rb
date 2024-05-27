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
FactoryBot.define do
  factory :product_attribute do
    price_cents { rand(1..1000) }
    whearhouse_count { rand(1..1000) }
    drop_shipping_available { [true, false].sample }
    sequence(:slug) { |n| "FFaker::Lorem.word#{n}" }
  end
end
