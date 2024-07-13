# frozen_string_literal: true

RSpec.describe BooksController do
  describe '#index' do
    before do
      create_list(:book, 2, :with_published_status)
      create_list(:book, 3, :with_unpublished_status)
      warden.set_user(user)
      get :index
    end

    context 'when user is not logged in' do
      let(:user) { nil }

      it 'returns status ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'renders the :index template' do
        expect(response).to render_template(:index)
      end

      it 'renders only published books' do
        expect(assigns(:books).all?(&:published)).to equal(true)
      end

      it 'renders correct amount of books' do
        expect(assigns(:books).count).to equal(2)
      end
    end

    context 'when user is logged in as manager' do
      let(:user) { create(:admin, :with_manager_role) }

      it 'returns status ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'renders the :index template' do
        expect(response).to render_template(:index)
      end

      it 'renders all books' do
        expect(assigns(:books).count).to equal(5)
      end
    end

    context 'when user is logged in as superadmin' do
      let(:user) { create(:admin, :with_superadmin_role) }

      it 'returns status ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'renders the :index template' do
        expect(response).to render_template(:index)
      end

      it 'renders all books' do
        expect(assigns(:books).count).to equal(5)
      end
    end
  end

  describe '#show' do
    let(:slug) { book.slug }

    before do
      warden.set_user(user)
      get :show, params: { slug: }
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
    # TODO: use shared examples when new admin role appears
  end
end
