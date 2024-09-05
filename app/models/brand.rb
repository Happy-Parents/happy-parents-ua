# frozen_string_literal: true

# == Schema Information
#
# Table name: brands
#
#  id              :bigint           not null, primary key
#  name            :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  manufacturer_id :bigint
#
# Indexes
#
#  index_brands_on_manufacturer_id           (manufacturer_id)
#  index_brands_on_name_and_manufacturer_id  (name,manufacturer_id) UNIQUE
#
class Brand < ApplicationRecord
  include RansackSearchable
  include RansackMobilitySearchable

  has_many :products, dependent: :nullify

  # TODO: move association columns to module
  def self.ransackable_associations(_auth_object = nil)
    ['manufacturer']
  end

  belongs_to :manufacturer, optional: true
  validates :name, presence: true,
                   uniqueness: {
                     scope: :manufacturer_id,
                     case_sensitive: false
                   }
end
