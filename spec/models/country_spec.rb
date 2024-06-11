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
RSpec.describe Country do
  subject(:supplier) { build(:country) }

  describe 'associations' do
    it { is_expected.to have_many(:manufacturers) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name_uk) }
    it { is_expected.to validate_presence_of(:name_ru) }
    # TODO: define custom validator and verify uniquness of name translations
    # it { is_expected.to validate_uniqueness_of(:name_ru).case_insensitive }
    # it { is_expected.to validate_uniqueness_of(:name_uk).case_insensitive }
  end
end
