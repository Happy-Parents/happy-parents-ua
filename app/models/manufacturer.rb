# frozen_string_literal: true

# == Schema Information
#
# Table name: manufacturers
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  country_id :bigint
#
# Indexes
#
#  index_manufacturers_on_country_id  (country_id)
#  index_manufacturers_on_name        (name) UNIQUE
#
# Represents product manufacturer entity
class Manufacturer < ApplicationRecord
  include RanSackableAttributable

  # TODO: move association columns to module
  def self.ransackable_associations(_auth_object = nil)
    ['country']
  end
  belongs_to :country

  validates :name, presence: true, uniqueness: true
end
