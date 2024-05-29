# frozen_string_literal: true

# == Schema Information
#
# Table name: books
#
#  id          :bigint           not null, primary key
#  cover_type  :integer          not null
#  language    :integer          not null
#  pages_count :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :book do
    cover_type { rand(0..1) }
    pages_count { rand(1..100) }
    language { rand(0..2) }
    after(:create) do |book|
      create(:product_attribute, product_attributable: book)
    end
  end
end
