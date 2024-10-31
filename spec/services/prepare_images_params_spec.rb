# frozen_string_literal: true

RSpec.describe PrepareImagesParams do
  let(:called_service) { described_class.call(params) }
  let(:params) do
    ActionController::Parameters.new({ id: product_id, product: product_attrs })
  end

  context 'when product does not exist' do
    let(:product_id) { [nil, rand(1..10)].sample }
    let(:product_attrs) { nil }

    it 'raises ActiveRecordRecordNotFound error' do
      expect { called_service }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  context 'when product with images exist and product attrs includes some images data' do
    let(:product_id) { product.id }
    let(:product) { create(:product, :with_image) }
    let(:product_attrs) { { foo: :bar, images: ['some_image_data'] } }

    it 'returns product attrs with images data' do
      expect(called_service.permit!.to_h).to eq({ 'foo' => :bar, 'images' => ['some_image_data'] })
    end
  end

  context 'when product with images exist and product attrs is empty' do
    let(:product_id) { product.id }
    let(:product) { create(:product, :with_image) }
    let(:product_attrs) { { foo: :bar, images: [''] } }

    it 'returns product attrs without images data' do
      expect(called_service.permit!.to_h).to eq({ 'foo' => :bar })
    end
  end

  context 'when product has no images and product attrs is empty' do
    let(:product_id) { product.id }
    let(:product) { create(:product) }
    let(:product_attrs) { { foo: :bar, images: [''] } }

    it 'returns product attrs qirh images data' do
      expect(called_service.permit!.to_h).to eq({ 'foo' => :bar, 'images' => [''] })
    end
  end

  context 'when product has no images and product attrs includes some images data' do
    let(:product_id) { product.id }
    let(:product) { create(:product) }
    let(:product_attrs) { { foo: :bar, images: ['some_image_data'] } }

    it 'returns product attrs qirh images data' do
      expect(called_service.permit!.to_h).to eq({ 'foo' => :bar, 'images' => ['some_image_data'] })
    end
  end
end
