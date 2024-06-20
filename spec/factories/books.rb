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
    cover_type { [0, 1].sample }
    language { [0, 1, 2].sample }
    pages_count { rand(0..100) }
  end
end
