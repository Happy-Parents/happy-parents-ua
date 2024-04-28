# frozen_string_literal: true

# == Schema Information
#
# Table name: trade_marks
#
#  id              :bigint           not null, primary key
#  name            :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  manufacturer_id :bigint
#
# Indexes
#
#  index_trade_marks_on_manufacturer_id           (manufacturer_id)
#  index_trade_marks_on_name_and_manufacturer_id  (name,manufacturer_id) UNIQUE
#
FactoryBot.define do
  factory :trade_mark do
    manufacturer
    sequence(:name) { |n| "#{FFaker::Lorem.word}-#{n}" }
  end
end
