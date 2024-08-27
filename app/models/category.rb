# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# Represents product category
class Category < ApplicationRecord
  include RanSackableAttributable
  extend Mobility

  translates :name, type: :string
  # TODO: validateuniqueness of translated names
  validates :name_uk,
            :name_ru,
            presence: true
end
