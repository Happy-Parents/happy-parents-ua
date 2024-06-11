# frozen_string_literal: true

# == Schema Information
#
# Table name: countries
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# Represents manufacturer country entity
class Country < ApplicationRecord
  include RanSackableAttributable
  extend Mobility
  has_many :manufacturers, dependent: :nullify
  translates :name, type: :string

  validates :name_uk,
            :name_ru,
            presence: true

  # TODO: implement custom uniq valiadtion:
  # https://github.com/shioyama/mobility/issues/20
  # I18n.available_locales.each do |locale|
  #   validates :"name_#{locale}", presence: true, uniqueness: true
  # end
end
