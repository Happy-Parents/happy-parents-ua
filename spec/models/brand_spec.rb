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

RSpec.describe Brand do
  subject(:brand) { build(:brand) }

  describe 'associations' do
    it { is_expected.to belong_to(:manufacturer).optional }
    it { is_expected.to have_many(:products).dependent(:nullify) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:manufacturer_id).case_insensitive }
  end
end
