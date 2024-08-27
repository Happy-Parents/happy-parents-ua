# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
RSpec.describe Category do
  subject(:category) { build(:category) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name_uk) }
    it { is_expected.to validate_presence_of(:name_ru) }
  end
end
