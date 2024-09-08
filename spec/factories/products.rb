# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id                      :bigint           not null, primary key
#  age_range               :integer
#  drop_shipping_available :boolean          default(FALSE), not null
#  inventory_number        :string           not null
#  price_cents             :integer          not null
#  published               :boolean          default(FALSE), not null
#  slug                    :string           not null
#  specifications          :jsonb            not null
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
FactoryBot.define do
  factory :product do
    sequence(:inventory_number) { |n| "#{FFaker::Lorem.word}-#{n}" }
    sequence(:slug) { |n| "#{FFaker::Lorem.words(2).join('-')}-#{n}" }
    sequence(:name_uk) { |n| "#{FFaker::Lorem.word}-#{n}" }
    sequence(:name_ru) { |n| "#{FFaker::Lorem.word}-#{n}" }
    sequence(:preview_uk) { |n| "#{FFaker::Lorem.sentence}-#{n}" }
    sequence(:preview_ru) { |n| "#{FFaker::Lorem.sentence}-#{n}" }
    sequence(:description_uk) { |n| "#{FFaker::Lorem.word}-#{n}" }
    sequence(:description_ru) { |n| "#{FFaker::Lorem.word}-#{n}" }
    drop_shipping_available { [true, false].sample }
    stock_balance { rand(0..100) }
    price_cents { rand(1..10_000) }
    published { [true, false].sample }
    age_range { rand(0..5) }

    trait :with_published_status do
      published { true }
    end

    trait :with_unpublished_status do
      published { false }
    end

    trait :with_manufacturer do
      manufacturer
    end

    trait :with_brand do
      brand
    end
  end
end
