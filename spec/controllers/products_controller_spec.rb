# frozen_string_literal: true

RSpec.describe ProductsController do
  describe '#show' do
    let(:slug) { product.slug }

    before do
      warden.set_user(user)
      get :show, params: { slug: }
    end

    context 'when user is not loged in' do
      let(:user) { nil }

      context 'when product is published' do
        let(:product) { create(:product, :with_published_status) }

        it 'returns status ok' do
          expect(response).to have_http_status(:ok)
        end

        it 'renders the :show template' do
          expect(response).to render_template(:show)
        end
      end

      context 'when product is not published' do
        let(:product) { create(:product, :with_unpublished_status) }

        it 'returns status not_found' do
          expect(response).to have_http_status(:not_found)
        end
      end
    end

    context 'when user is looged in as manager' do
      let(:user) { create(:admin, :with_manager_role) }

      context 'when product is published' do
        let(:product) { create(:product, :with_published_status) }

        it 'returns status ok' do
          expect(response).to have_http_status(:ok)
        end

        it 'renders the :show template' do
          expect(response).to render_template(:show)
        end
      end

      context 'when product is not published' do
        let(:product) { create(:product, :with_unpublished_status) }

        it 'returns status ok' do
          expect(response).to have_http_status(:ok)
        end

        it 'renders the :show template' do
          expect(response).to render_template(:show)
        end
      end
    end

    context 'when user is looged in as superadmin' do
      let(:user) { create(:admin, :with_superadmin_role) }

      context 'when product is published' do
        let(:product) { create(:product, :with_published_status) }

        it 'returns status ok' do
          expect(response).to have_http_status(:ok)
        end

        it 'renders the :show template' do
          expect(response).to render_template(:show)
        end
      end

      context 'when product is not published' do
        let(:product) { create(:product, :with_unpublished_status) }

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
