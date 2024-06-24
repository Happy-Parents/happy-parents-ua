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
FactoryBot.define do
  factory :product do
    manufacturer
    sequence(:inventory_number) { |n| "#{FFaker::Lorem.word}-#{n}" }
    sequence(:slug) { |n| "#{FFaker::Lorem.words(2).join('-')}-#{n}" }
    sequence(:name_uk) { |n| "#{FFaker::Lorem.word}-#{n}" }
    sequence(:name_ru) { |n| "#{FFaker::Lorem.word}-#{n}" }
    drop_shipping_available { [true, false].sample }
    whearhouse_count { rand(0..100) }
    price_cents { rand(1..10_000) }
    published { [true, false].sample }
  end
end
