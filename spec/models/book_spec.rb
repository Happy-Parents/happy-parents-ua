# frozen_string_literal: true

# == Schema Information
#
# Table name: books
#
#  id          :bigint           not null, primary key
#  cover_type  :integer          not null
#  language    :integer          not null
#  pages_count :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'rails_helper'

RSpec.describe Book do
  describe 'associations' do
    it { is_expected.to have_one(:product_attribute) }
  end

  describe 'validations' do
    %i[cover_type language].each do |attribute|
      it { is_expected.to validate_presence_of(attribute) }
    end
  end
end