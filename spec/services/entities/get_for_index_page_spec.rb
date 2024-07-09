# frozen_string_literal: true

RSpec.describe Entities::GetForIndexPage do
  subject(:called_service) { described_class.call(**arguments) }

  let(:arguments) do
    {
      entity_class:,
      policy_class:,
      user:
    }
  end

  let(:entity_class) { instance_double(Entity) }
  let(:policy_class) { instance_double(Policy) }
  let(:user) { instance_double(User) }
  let(:user_permissions) { instance_double(UserPermissions) }
  let(:published_collection) { instance_double(PublidhedCollection) }
  let(:full_collection) { 'full_collection' }
  let(:access_permission) { [true, false].sample }

  before do
    stub_const('Entity', Class.new)
    stub_const('Policy', Class.new)
    stub_const('User', Class.new)
    stub_const('UserPermissions', Class.new)
    stub_const('PublidhedCollection', Class.new)

    allow(entity_class).to receive_messages(all: full_collection,
                                            published: published_collection)

    allow(published_collection).to receive(:all).and_return(published_collection)

    allow(policy_class).to receive(:new).with(user, entity_class).and_return(user_permissions)

    allow(user_permissions).to receive(:index?)
                           .and_return(access_permission)
  end

  context 'when user has access to published entities' do
    let(:access_permission) { true }

    it { is_expected.to equal(full_collection) }
  end

  context 'when user has no access to published entities' do
    let(:access_permission) { false }

    it { is_expected.to equal(published_collection) }
  end

  context 'when user is not logged in' do
    let(:user) { nil }

    it { is_expected.to equal(published_collection) }
  end
end
