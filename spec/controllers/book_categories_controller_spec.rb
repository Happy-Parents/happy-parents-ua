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
end
