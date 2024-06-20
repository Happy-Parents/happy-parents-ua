# frozen_string_literal: true

# == Schema Information
#
# Table name: manufacturers
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  country_id :bigint
#
# Indexes
#
#  index_manufacturers_on_country_id           (country_id)
#  index_manufacturers_on_name_and_country_id  (name,country_id) UNIQUE
#
class Manufacturer < ApplicationRecord
  include RanSackableAttributable

  # TODO: move association columns to module
  def self.ransackable_associations(_auth_object = nil)
    ['country']
  end
  belongs_to :country
  has_many :trade_marks, dependent: :nullify
  has_many :products, dependent: :nullify

  validates :name, presence: true,
                   uniqueness: {
                     scope: :country_id,
                     case_sensitive: false
                   }
end
