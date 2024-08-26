# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id                      :bigint           not null, primary key
#  drop_shipping_available :boolean          default(FALSE), not null
#  inventory_number        :string           not null
#  price_cents             :integer          not null
#  published               :boolean          default(FALSE), not null
#  slug                    :string           not null
#  stock_balance           :integer          not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  manufacturer_id         :bigint
#  trade_mark_id           :bigint
#
# Indexes
#
#  index_products_on_inventory_number  (inventory_number) UNIQUE
#  index_products_on_manufacturer_id   (manufacturer_id)
#  index_products_on_slug              (slug) UNIQUE
#  index_products_on_trade_mark_id     (trade_mark_id)
#
# Foreign Keys
#
#  fk_rails_...  (trade_mark_id => trade_marks.id)
#
require 'rails_helper'

RSpec.describe Product do
  subject(:product) { build(:product, drop_shipping_available:, stock_balance:) }

  let(:drop_shipping_available) { [true, false].sample }
  let(:stock_balance) { rand(0..2) }

  describe 'associations' do
    %i[manufacturer trade_mark].each do |entity|
      it { is_expected.to belong_to(entity).optional }
    end
  end

  describe 'validations' do
    %i[
      name_uk
      name_ru
      slug
      price_cents
      stock_balance
      inventory_number
    ].each do |attribute|
      it { is_expected.to validate_presence_of(attribute) }
    end
    it { is_expected.to validate_uniqueness_of(:slug).case_insensitive }
    it { is_expected.to validate_uniqueness_of(:inventory_number).case_insensitive }
    it { is_expected.to validate_numericality_of(:price_cents).is_greater_than(0) }
    it { is_expected.to validate_numericality_of(:stock_balance).is_greater_than_or_equal_to(0) }

    context 'when translated names are not unique for a new record' do
      let(:existing_product) { create(:product) }

      let(:new_product) do
        build(:product, name_uk: existing_product.name_uk,
                        name_ru: existing_product.name_ru)
      end

      it 'object is invalid' do
        skip 'revise translated names uniqueness validation'
        expect(new_product.valid?).to equal(false)
      end

      it 'object has expected errors' do
        skip 'revise translated names uniqueness validation'
        # TODO: add example for update
        new_product.valid?
        expect(new_product.errors.messages).to eq({ name_uk: ['must be unique'],
                                                    name_ru: ['must be unique'] })
      end
    end
  end

  describe 'instance methods' do
    describe '#in_stock?' do
      context 'when drop shipping is available &stock balance is greater than 0' do
        let(:drop_shipping_available) { true }
        let(:stock_balance) { rand(1..3) }

        it 'returns true' do
          expect(product.in_stock?).to equal(true)
        end
      end

      context 'when drop shipping is available & stock balance is 0' do
        let(:drop_shipping_available) { true }
        let(:stock_balance) { 0 }

        it 'returns true' do
          expect(product.in_stock?).to equal(true)
        end
      end

      context 'when drop shipping is not available & stock balance is greater than 0' do
        let(:drop_shipping_available) { false }
        let(:stock_balance) { rand(1..3) }

        it 'returns true' do
          expect(product.in_stock?).to equal(true)
        end
      end

      context 'when drop shipping is not available & stock balance is 0' do
        let(:drop_shipping_available) { false }
        let(:stock_balance) { 0 }

        it 'returns true' do
          expect(product.in_stock?).to equal(false)
        end
      end
    end
  end
end
