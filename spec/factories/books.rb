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
FactoryBot.define do
  factory :book do
    product
    authors { FFaker::Lorem.words(2).map(&:capitalize).join(', ') }
    cover_type { [0, 1].sample }
    language { [0, 1, 2].sample }
    pages_count { rand(1..100) }

    trait :with_published_status do
      product factory: %i[product with_published_status]
    end

    trait :with_unpublished_status do
      product factory: %i[product with_unpublished_status]
    end
  end
end
