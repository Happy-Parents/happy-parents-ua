# frozen_string_literal: true

# == Schema Information
#
# Table name: skills
#
#  id :bigint           not null, primary key
#

# Represents child's skill that the product develops
class Skill < ApplicationRecord
  include RanSackableAttributable
  extend Mobility
  translates :name, type: :string

  # TODO: add uniquness validation
  validates :name_uk,
            :name_ru,
            presence: true
end
