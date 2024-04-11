# frozen_string_literal: true

module ActiveAdmin
  # ActiveAdmin Page policy
  class PagePolicy < ApplicationPolicy
    def index?
      false
    end

    def show?
      record.name == ALL_USERS_ALLOWED_PAGE
    end
  end
end
