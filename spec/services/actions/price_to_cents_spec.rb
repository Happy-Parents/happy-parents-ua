# frozen_string_literal: true

RSpec.describe Actions::PriceToCents do
  subject(:price_cents) { described_class.call(price) }

  describe 'price is valid' do
    context 'when 0' do
      let(:price) { 0 }

      it { is_expected.to equal(0) }
    end

    context 'when stringified 0' do
      let(:price) { '0' }

      it { is_expected.to equal(0) }
    end

    context 'when integer' do
      let(:price) { 50 }

      it { is_expected.to equal(5000) }
    end

    context 'when stringified integer' do
      let(:price) { '50' }

      it { is_expected.to equal(5000) }
    end

    context 'when stringified float' do
      let(:price) { '50.50' }

      it { is_expected.to equal(5050) }
    end

    context 'when valid stringified float with ₴ sign' do
      let(:price) { '60.11 ₴' }

      it { is_expected.to equal(6011) }
    end

    context 'when valid stringified integer with ₴ sign' do
      let(:price) { '60 ₴' }

      it { is_expected.to equal(6000) }
    end
  end

  describe 'price is invalid' do
    context 'when nil' do
      let(:price) { nil }

      it { is_expected.to equal(0) }
    end

    context 'when random string' do
      let(:price) { FFaker::Lorem.word }

      it { is_expected.to equal(0) }
    end

    context 'when stringified float with wrong delimeter' do
      let(:price) { '50,35' }

      it { is_expected.to equal(0) }
    end

    context 'when stringified float too many delimeters' do
      let(:price) { '50.25.25' }

      it { is_expected.to equal(0) }
    end
  end
end
