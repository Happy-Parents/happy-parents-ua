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

# Represents Book product entity
class Book < ApplicationRecord
  has_one :product_attributes, as: :product_attributable, dependent: :destroy
  validates :cover_type, :language, presence: true
  enum cover_type: { hard: 0, soft: 1 }
  enum language: { uk: 0, eng: 1, ru: 2 }
end
