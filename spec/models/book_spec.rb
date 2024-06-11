# frozen_string_literal: true

# == Schema Information
#
# Table name: books
#
#  id                      :bigint           not null, primary key
#  authors                 :string
#  cover_type              :integer          not null
#  drop_shipping_available :boolean          default(FALSE), not null
#  language                :integer          not null
#  name                    :string
#  pages_count             :integer          not null
#  price_cents             :integer          not null
#  published               :boolean          default(FALSE), not null
#  slug                    :string           not null
#  whearhouse_count        :integer          not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  manufacturer_id         :bigint
#
# Indexes
#
#  index_books_on_manufacturer_id  (manufacturer_id)
#  index_books_on_slug             (slug) UNIQUE
#
require 'rails_helper'

RSpec.describe Book do
  subject(:book) { build(:book) }

  describe 'associations' do
    it { is_expected.to belong_to(:manufacturer).optional }
  end

  describe 'validations' do
    %i[
      name_uk
      name_ru
      cover_type
      language
      pages_count
      slug
      price_cents
      whearhouse_count
    ].each do |attribute|
      it { is_expected.to validate_presence_of(attribute) }
    end
    it { is_expected.to validate_numericality_of(:price_cents).is_greater_than(0) }
    it { is_expected.to validate_numericality_of(:whearhouse_count).is_greater_than_or_equal_to(0) }
    it { is_expected.to define_enum_for(:language).with_values(%i[uk eng ru]) }
    it { is_expected.to define_enum_for(:cover_type).with_values(%i[hard soft]) }
  end
end
