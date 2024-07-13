# frozen_string_literal: true

RSpec.describe BookCategoriesController do
  describe '#index' do
    before do
      create_list(:book_category, count)
      get :index
    end

    let(:count) { rand(1..5) }

    it 'returns status ok' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the :index template' do
      expect(response).to render_template(:index)
    end

    it 'renders correct amount of books' do
      expect(assigns(:book_categories).count).to equal(count)
    end
  end

  describe '#show' do
    before do
      warden.set_user(user)
      get :show, params: { slug: }
    end

    let(:book_category) do
      bc = create(:book_category)
      bc.books << create_list(:book, published_book_amount, :with_published_status)
      bc.books << create_list(:book, unpublished_book_amount, :with_unpublished_status)
      bc
    end
    let(:published_book_amount) { rand(1..4) }
    let(:unpublished_book_amount) { rand(5..8) }
    let(:user) { nil }

    describe 'for not nogged in user' do
      context 'when category could not be not_found' do
        let(:slug) { FFaker::Lorem.word }

        it 'returns status not_found' do
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'when category has unpublished books' do
        let(:slug) { book_category.slug }

        it 'returns status ok' do
          expect(response).to have_http_status(:ok)
        end

        it 'renders the :show template' do
          expect(response).to render_template(:show)
        end

        it 'renders category with correct books amount' do
          expect(assigns(:book_category).books.size).to equal(published_book_amount)
        end

        it 'renders category only with published books' do
          expect(assigns(:book_category).books.map(&:published).all?(true)).to equal(true)
        end
      end
    end

    describe 'for logged in manager' do
      let(:user) { create(:admin, :with_manager_role) }

      context 'when category could not be not_found' do
        let(:slug) { FFaker::Lorem.word }

        it 'returns status not_found' do
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'when category has unpublished books' do
        let(:slug) { book_category.slug }

        it 'returns status ok' do
          expect(response).to have_http_status(:ok)
        end

        it 'renders the :show template' do
          expect(response).to render_template(:show)
        end

        it 'renders category with correct books amount' do
          expect(assigns(:book_category).books.size).to equal(published_book_amount + unpublished_book_amount)
        end
      end
    end

    describe 'for logged in superadmin' do
      let(:user) { create(:admin, :with_superadmin_role) }

      context 'when category could not be not_found' do
        let(:slug) { FFaker::Lorem.word }

        it 'returns status not_found' do
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'when category has unpublished books' do
        let(:slug) { book_category.slug }

        it 'returns status ok' do
          expect(response).to have_http_status(:ok)
        end

        it 'renders the :show template' do
          expect(response).to render_template(:show)
        end

        it 'renders category with correct books amount' do
          expect(assigns(:book_category).books.size).to equal(published_book_amount + unpublished_book_amount)
        end
      end
    end
    # TODO: use shared examples when new admin role appears
  end
end
