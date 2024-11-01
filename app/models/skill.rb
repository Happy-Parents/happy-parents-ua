# frozen_string_literal: true

# == Schema Information
#
# Table name: skills
#
#  id :bigint           not null, primary key
#

# Represents child's skill that the product develops
class Skill < ApplicationRecord
  include RansackSearchable
  include RansackMobilitySearchable
  extend Mobility
  translates :name, type: :string

  has_and_belongs_to_many :products

  # TODO: add uniquness validation
  validates :name_uk,
            :name_ru,
            presence: true
end
