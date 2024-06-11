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
RSpec.describe Manufacturer do
  subject(:manufacturer) { build(:manufacturer) }

  describe 'associations' do
    it { is_expected.to belong_to(:country) }
    it { is_expected.to have_many(:trade_marks) }
    it { is_expected.to have_many(:books) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:country_id).case_insensitive }
  end
end
