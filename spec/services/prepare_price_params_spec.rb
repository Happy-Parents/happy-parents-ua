# frozen_string_literal: true

RSpec.describe PreparePriceParams do
  subject(:called_service) { described_class.call(params) }

  let(:params) { {} }

  context 'when params does not includ price params' do
    let(:params) { { foo: :bar } }

    it 'returns same params with no changes' do
      expect(called_service).to eq({ foo: :bar })
    end
  end

  context 'when params includes price' do
    let(:params) { { foo: :bar, 'price' => price_argument } }

    let(:price_argument) { :price_argument }
    let(:price_cents) { :price_cents }

    before do
      allow(Actions::PriceToCents).to receive(:call).with(price_argument).and_return(price_cents)
    end

    it 'returns modified params with price_cents parameter included' do
      expect(called_service).to eq({ :foo => :bar, 'price_cents' => :price_cents })
    end
  end
end
