# frozen_string_literal: true

# == Schema Information
#
# Table name: materials
#
#  id :bigint           not null, primary key
#
RSpec.describe Material do
  subject(:skill) { build(:material) }

  describe 'associations' do
    it { is_expected.to have_many(:products).dependent(:nullify) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name_uk) }
    it { is_expected.to validate_presence_of(:name_ru) }
    # TODO: define custom validator and verify uniquness of name translations
    # it { is_expected.to validate_uniqueness_of(:name_ru).case_insensitive }
    # it { is_expected.to validate_uniqueness_of(:name_uk).case_insensitive }
  end
end
