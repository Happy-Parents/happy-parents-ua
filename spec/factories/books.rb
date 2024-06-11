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
FactoryBot.define do
  factory :book do
    sequence(:name_uk) { |n| "#{FFaker::Lorem.word}-#{n}" }
    sequence(:name_ru) { |n| "#{FFaker::Lorem.word}-#{n}" }
    cover_type { [0, 1].sample }
    drop_shipping_available { [true, false].sample }
    language { [0, 1, 2].sample }
    pages_count { rand(0..100) }
    whearhouse_count { rand(0..100) }
    price_cents { rand(1..10_000) }
    published { [true, false].sample }
    sequence(:slug) { |n| "#{FFaker::Lorem.words(2).join('-')}-#{n}" }

    trait :with_manufacturer do
      manufacturer
    end
  end
end
