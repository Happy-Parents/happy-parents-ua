# frozen_string_literal: true

module Entities
  # Responsible for retrieving product/page/etc.
  # For ui index page depending on plicy and published status
  class GetForIndexPage
    extend Callable

    def initialize(entity_class:, policy_class:, user:)
      @entity_class = entity_class
      @policy_class = policy_class
      @user = user
    end

    def call
      return entity_class.all if user && access_allowed?

      entity_class.published.all
    end

    private

    attr_reader :entity_class, :policy_class, :user

    def access_allowed?
      policy_class.new(user, entity_class).index?
    end
  end
end
