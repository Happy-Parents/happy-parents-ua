# frozen_string_literal: true

# == Schema Information
#
# Table name: books
#
#  id          :bigint           not null, primary key
#  authors     :string
#  cover_type  :integer          not null
#  language    :integer          not null
#  pages_count :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  product_id  :bigint
#

RSpec.describe Book do
  subject(:book) { build(:book) }

  describe 'associations' do
    it { is_expected.to belong_to(:product) }
    it { is_expected.to have_and_belong_to_many(:book_categories) }
  end

  describe 'delegations' do
    %i[drop_shipping_available
       drop_shipping_available?
       inventory_number
       name
       name_uk
       name_ru
       price
       published
       published?
       slug
       stock_balance
       manufacturer
       in_stock?].each do |method|
      it { is_expected.to delegate_method(method).to(:product) }
    end
  end

  describe 'validations' do
    %i[cover_type language pages_count].each do |attribute|
      it { is_expected.to validate_presence_of(attribute) }
    end

    it { is_expected.to validate_numericality_of(:pages_count).is_greater_than(0) }
    it { is_expected.to define_enum_for(:language).with_values(%i[uk eng ru]) }
    it { is_expected.to define_enum_for(:cover_type).with_values(%i[hard soft]) }
  end

  describe 'slass methods' do
    describe '#find_by_slug' do
      let(:slug) { book.slug }
      let(:book) { create(:book) }

      it 'finds and returns book by slug' do
        expect(described_class.find_by_slug(slug).id).to equal(book.id)
      end
    end

    describe '#published scope' do
      before { create_list(:book, 2, :with_unpublished_status) }

      let(:published_books) { create_list(:book, 2, :with_published_status) }

      it 'returns only published books' do
        expect(described_class.published).to match_array(published_books)
      end
    end
  end
end
