# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id                      :bigint           not null, primary key
#  drop_shipping_available :boolean          default(FALSE), not null
#  inventory_number        :string           not null
#  name                    :string
#  price_cents             :integer          not null
#  published               :boolean          default(FALSE), not null
#  slug                    :string           not null
#  whearhouse_count        :integer          not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  manufacturer_id         :bigint
#
# Indexes
#
#  index_products_on_inventory_number  (inventory_number) UNIQUE
#  index_products_on_manufacturer_id   (manufacturer_id)
#  index_products_on_slug              (slug) UNIQUE
#
require 'rails_helper'

RSpec.describe Product do
  subject(:product) { build(:product) }

  describe 'associations' do
    it { is_expected.to belong_to(:manufacturer).optional }
  end

  describe 'validations' do
    %i[
      name_uk
      name_ru
      slug
      price_cents
      whearhouse_count
      inventory_number
    ].each do |attribute|
      it { is_expected.to validate_presence_of(attribute) }
    end
    it { is_expected.to validate_uniqueness_of(:slug).case_insensitive }
    it { is_expected.to validate_uniqueness_of(:inventory_number).case_insensitive }
    it { is_expected.to validate_numericality_of(:price_cents).is_greater_than(0) }
    it { is_expected.to validate_numericality_of(:whearhouse_count).is_greater_than_or_equal_to(0) }
  end
end
