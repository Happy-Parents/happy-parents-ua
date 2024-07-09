# frozen_string_literal: true

RSpec.describe Category do
  subject(:category) { build(:category) }

  describe 'associations' do
    it { is_expected.to have_and_belong_to_many(:books) }
  end
end
