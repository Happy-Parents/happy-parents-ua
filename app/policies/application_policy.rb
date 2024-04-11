# frozen_string_literal: true

# Basic Policy to be inhereted from
class ApplicationPolicy
  ALL_USERS_ALLOWED_PAGE = 'Dashboard'
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def new?
    create?
  end

  def create?
    false
  end

  def edit?
    update?
  end

  def update?
    false
  end

  def destroy?
    false
  end

  def destroy_all?
    destroy?
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  # Scope policies
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end

  private

  def admin_permissions?
    %w[superadmin manager].include? user.role
  end
end
