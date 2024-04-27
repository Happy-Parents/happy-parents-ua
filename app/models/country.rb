# frozen_string_literal: true

# == Schema Information
#
# Table name: countries
#
#  id   :bigint           not null, primary key
#  name :string
#
class Country < ApplicationRecord
  include RanSackableAttributable
  extend Mobility
  translates :name, type: :string

  validates :name_uk,
            :name_ru,
            presence: true

  # I18n.available_locales.each do |locale|
  #   validates :"name_#{locale}", presence: true, uniqueness: true
  # end
end
