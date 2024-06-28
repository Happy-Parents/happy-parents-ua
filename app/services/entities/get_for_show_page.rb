# frozen_string_literal: true

module Entities
  # Responsible for retrieving product/page/etc.
  # For ui show page depending on plicy and published status
  class GetForShowPage
    extend Callable

    def initialize(entity_class:, entity_slug:, policy_class:, user:)
      @entity_class = entity_class
      @entity_slug = entity_slug
      @policy_class = policy_class
      @user = user
    end

    def call
      return entity if entity.published

      raise ActiveRecord::RecordNotFound unless access_allowed

      entity
    end

    private

    attr_reader :entity_class, :entity_slug, :policy_class, :user

    def entity
      @entity ||= entity_class.find_by_slug(entity_slug)
    end

    def access_allowed
      user && policy_class.new(user, entity).show?
    end
  end
end
