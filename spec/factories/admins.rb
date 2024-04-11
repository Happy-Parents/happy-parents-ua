# frozen_string_literal: true

# == Schema Information
#
# Table name: admins
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_admins_on_email                 (email) UNIQUE
#  index_admins_on_reset_password_token  (reset_password_token) UNIQUE
#
FactoryBot.define do
  factory :admin do
    sequence(:email) { |n| "#{FFaker::Internet.unique.email}#{n}" }
    role { rand(0..1) }
    password { FFaker::Internet.password }

    trait :with_superadmin_role do
      role { 0 }
    end

    trait :with_manager_role do
      role { 1 }
    end
  end
end
