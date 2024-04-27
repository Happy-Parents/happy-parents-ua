# frozen_string_literal: true

# == Schema Information
#
# Table name: countries
#
#  id   :bigint           not null, primary key
#  name :string
#
RSpec.describe Country do
  subject(:supplier) { build(:country) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name_uk) }
    it { is_expected.to validate_presence_of(:name_ru) }
    # TODO: define custom validator and verify uniquness of name translations
    # it { is_expected.to validate_uniqueness_of(:name_ru).case_insensitive }
    # it { is_expected.to validate_uniqueness_of(:name_uk).case_insensitive }
  end
end
