# frozen_string_literal: true

RSpec.describe PrepareSpecificationsParams do
  subject(:called_service) { described_class.call(params) }

  let(:params) { {} }

  context 'when params does not include specifications' do
    let(:params) { { foo: :bar } }

    it 'returns same params with no changes' do
      expect(called_service).to eq({ foo: :bar })
    end
  end

  context 'when params includes specifications' do
    let(:params) { { foo: :bar, specifications: specifications_json } }

    context 'when specifications is valid json string' do
      let(:specifications_json) { '{"weight":"1kg"}' }

      it 'returns modified params that includes parsed specifications' do
        expect(called_service).to eq({ foo: :bar, specifications: { 'weight' => '1kg' } })
      end
    end

    context 'when specifications is in_valid json string' do
      let(:specifications_json) { FFaker::Lorem.word }

      it 'returns modified params that includes parsed specifications' do
        expect { called_service }.to raise_error(JSON::ParserError)
      end
    end
  end
end
