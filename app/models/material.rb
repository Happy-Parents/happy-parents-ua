# frozen_string_literal: true

# == Schema Information
#
# Table name: materials
#
#  id :bigint           not null, primary key
#
# frozent_string_literal: true

# Represents Material of the Product entity
class Material < ApplicationRecord
  include RansackSearchable
  include RansackMobilitySearchable
  extend Mobility
  translates :name, type: :string

  has_many :products, dependent: :nullify

  # TODO: add uniquness validation
  validates :name_uk,
            :name_ru,
            presence: true
end
