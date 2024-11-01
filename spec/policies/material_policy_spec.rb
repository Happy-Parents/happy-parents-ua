# frozen_string_literal: true

RSpec.describe MaterialPolicy do
  subject { described_class.new(user, record) }

  let(:record) { Material.new }

  describe 'with superadmin permisions' do
    let(:user) { build(:admin, :with_superadmin_role) }

    it { is_expected.to permit_all_actions }
  end

  describe 'with manager permisions' do
    let(:user) { build(:admin, :with_manager_role) }

    it { is_expected.to permit_all_actions }
  end
end
