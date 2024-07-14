# frozen_string_literal: true

RSpec.describe Resources::Publishable::GetForShowPage do
  subject(:called_service) { described_class.call(**arguments) }

  let(:arguments) do
    {
      entity_class:,
      entity_slug:,
      policy_class:,
      user:
    }
  end

  let(:entity_class) { instance_double(Entity) }
  let(:entity_slug) { FFaker::Lorem.word }
  let(:policy_class) { instance_double(Policy) }
  let(:user) { instance_double(User) }

  let(:user_permissions) { instance_double(UserPermissions) }
  let(:entity_instance) { instance_double(EntityInstance) }

  before do
    stub_const('Entity', Class.new)
    stub_const('Policy', Class.new)
    stub_const('User', Class.new)

    stub_const('UserPermissions', Class.new)
    stub_const('EntityInstance', Class.new)
  end

  context 'when entity does not exist' do
    before do
      allow(entity_class).to receive(:find_by_slug).with(entity_slug)
                                                   .and_raise(ActiveRecord::RecordNotFound)
    end

    it 'raises ActiveRecord::RecordNotFound error' do
      expect { called_service }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  context 'when entity exists' do
    before do
      allow(entity_class).to receive(:find_by_slug).with(entity_slug)
                                                   .and_return(entity_instance)
    end

    context 'when entity published' do
      before { allow(entity_instance).to receive(:published).and_return(true) }

      it 'returns found entity instance as a result' do
        expect(called_service).to eq(entity_instance)
      end
    end

    context 'when entity not published' do
      before { allow(entity_instance).to receive(:published).and_return(false) }

      context 'when user is not given' do
        let(:user) { nil }

        it 'raises ActiveRecord::RecordNotFound error' do
          expect { called_service }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end

      context 'when user has access permission' do
        before do
          allow(policy_class).to receive(:new)
                             .with(user, entity_instance)
            .and_return(user_permissions)
          allow(user_permissions).to receive(:show?).and_return(true)
        end

        it 'returns entity instance as a result' do
          expect(called_service).to eq(entity_instance)
        end
      end

      context 'when user has no access permission' do
        before do
          allow(policy_class).to receive(:new)
                             .with(user, entity_instance)
            .and_return(user_permissions)
          allow(user_permissions).to receive(:show?).and_return(false)
        end

        it 'raises ActiveRecord::RecordNotFound error' do
          expect { called_service }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end
end
