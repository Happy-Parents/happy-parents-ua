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
RSpec.describe Manufacturer do
  subject(:manufacturer) { build(:manufacturer) }

  describe 'associations' do
    it { is_expected.to belong_to(:country) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    # TODO: debug the problem and test uniqueness validation
    # it{ is_expected.to validate_uniqueness_of(:name) }
  end
end
