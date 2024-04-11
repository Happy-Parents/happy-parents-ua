# frozen_string_literal: true

# == Schema Information
#
# Table name: admins
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_admins_on_email                 (email) UNIQUE
#  index_admins_on_reset_password_token  (reset_password_token) UNIQUE
#

RSpec.describe Admin do
  subject(:admin) { build(:admin) }

  describe 'validations' do
    %i[email role password].map do |attribute|
      it { is_expected.to validate_presence_of(attribute) }
    end
    it { is_expected.to allow_value(FFaker::Internet.email).for(:email) }
    it { is_expected.not_to allow_value(FFaker::Lorem.word).for(:email) }

    it 'defines expected roles' do
      expect(admin).to define_enum_for(:role).with_values(superadmin: 0, manager: 1)
    end
  end
end
