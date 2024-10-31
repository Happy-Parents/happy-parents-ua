# frozen_string_literal: true

RSpec.describe DeleteProductImage do
  let(:service_call) { described_class.call(id: product_id, image_id:) }
  let(:product_id) { product.id }
  let(:product) { create(:product, :with_image) }
  let(:image_id) { product.images.last.id }

  it 'deletes product image' do
    expect { service_call }.to change(product.images, :count).from(1).to(0)
  end
end
