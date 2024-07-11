# frozen_string_literal: true

# == Schema Information
#
# Table name: book_categories
#
#  id         :bigint           not null, primary key
#  slug       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_book_categories_on_slug  (slug) UNIQUE
#
RSpec.describe BookCategory do
  subject(:category) { build(:book_category) }

  describe 'associations' do
    it { is_expected.to have_and_belong_to_many(:books) }
  end

  describe 'validations' do
    %i[slug name_uk name_ru].each do |attribute|
      it { is_expected.to validate_presence_of(attribute) }
    end
    it { is_expected.to validate_uniqueness_of(:slug).case_insensitive }
  end
end
