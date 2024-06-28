# frozen_string_literal: true

RSpec.describe BooksController do
  describe '#show' do
    let(:id) { book.id }

    before do
      warden.set_user(user)
      get :show, params: { id: }
    end

    context 'when user is not logged in' do
      let(:user) { nil }

      context 'when book is published' do
        let(:book) { create(:book, :with_published_status) }

        it 'returns status ok' do
          expect(response).to have_http_status(:ok)
        end

        it 'renders the :show template' do
          expect(response).to render_template(:show)
        end
      end

      context 'when book is not published' do
        let(:book) { create(:book, :with_unpublished_status) }

        it 'returns status not_found' do
          expect(response).to have_http_status(:not_found)
        end
      end
    end

    context 'when user is logged in as manager' do
      let(:user) { create(:admin, :with_manager_role) }

      context 'when book is published' do
        let(:book) { create(:book, :with_published_status) }

        it 'returns status ok' do
          expect(response).to have_http_status(:ok)
        end

        it 'renders the :show template' do
          expect(response).to render_template(:show)
        end
      end

      context 'when book is not published' do
        let(:book) { create(:book, :with_unpublished_status) }

        it 'returns status ok' do
          expect(response).to have_http_status(:ok)
        end

        it 'renders the :show template and' do
          expect(response).to render_template(:show)
        end
      end
    end

    context 'when user is logged in as superadmin' do
      let(:user) { create(:admin, :with_superadmin_role) }

      context 'when book is published' do
        let(:book) { create(:book, :with_published_status) }

        it 'returns status ok' do
          expect(response).to have_http_status(:ok)
        end

        it 'renders the :show template and' do
          expect(response).to render_template(:show)
        end
      end

      context 'when book is not published' do
        let(:book) { create(:book, :with_unpublished_status) }

        it 'returns status ok' do
          expect(response).to have_http_status(:ok)
        end

        it 'renders the :show template' do
          expect(response).to render_template(:show)
        end
      end
    end
  end
end
