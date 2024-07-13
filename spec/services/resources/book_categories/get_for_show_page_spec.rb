# frozen_string_literal: true

RSpec.describe Resources::BookCategories::GetForShowPage do
  subject(:called_service) { described_class.call(**args) }

  let(:args) { { slug:, user: } }

  let(:book_category) do
    category = create(:book_category)
    category.books << create_list(:book, unpublished_books_amount, :with_unpublished_status)
    category.books << create_list(:book, published_books_amount, :with_published_status)
    category
  end
  let(:unpublished_books_amount) { rand(1..4) }
  let(:published_books_amount) { rand(5..8) }

  describe 'for not authorized user' do
    let(:user) { nil }

    context 'when category with given slug does not exist' do
      let(:slug) { FFaker::Lorem.word }

      it 'raises ActiveRecord::RecordNotFound error' do
        expect { called_service }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when category has unpublished books' do
      let(:slug) { book_category.slug }

      it 'returns category correct amount of books' do
        expect(called_service.books.size).to equal(published_books_amount)
      end

      it 'returns category with only published books' do
        expect(called_service.books.map(&:published).all?(true)).to equal(true)
      end
    end
  end

  describe 'for authorized manager' do
    let(:user) { create(:admin, :with_manager_role) }

    context 'when category with given slug does not exist' do
      let(:slug) { FFaker::Lorem.word }

      it 'raises ActiveRecord::RecordNotFound error' do
        expect { called_service }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when category has unpublished books' do
      let(:slug) { book_category.slug }

      it 'returns category correct amount of books' do
        expect(called_service.books.size).to equal(published_books_amount + unpublished_books_amount)
      end
    end
  end

  describe 'for authorized superadmin' do
    let(:user) { create(:admin, :with_superadmin_role) }

    context 'when category with given slug does not exist' do
      let(:slug) { FFaker::Lorem.word }

      it 'raises ActiveRecord::RecordNotFound error' do
        expect { called_service }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when category has unpublished books' do
      let(:slug) { book_category.slug }

      it 'returns category correct amount of books' do
        expect(called_service.books.size).to equal(published_books_amount + unpublished_books_amount)
      end
    end
  end
end
