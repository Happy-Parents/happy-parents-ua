# frozen_string_literal: true

# == Schema Information
#
# Table name: books
#
#  id          :bigint           not null, primary key
#  authors     :string
#  cover_type  :integer          not null
#  language    :integer          not null
#  pages_count :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  product_id  :bigint
#

RSpec.describe Book do
  subject(:book) { build(:book) }

  describe 'associations' do
    it { is_expected.to belong_to(:product) }
  end

  describe 'validations' do
    %i[cover_type language pages_count].each do |attribute|
      it { is_expected.to validate_presence_of(attribute) }
    end
    it { is_expected.to define_enum_for(:language).with_values(%i[uk eng ru]) }
    it { is_expected.to define_enum_for(:cover_type).with_values(%i[hard soft]) }
  end
end
