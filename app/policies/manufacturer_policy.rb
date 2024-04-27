# frozen_string_literal: true

# Defines user permissions to interact with Country entity
class ManufacturerPolicy < ApplicationPolicy
  def index?
    admin_permissions?
  end

  def show?
    admin_permissions?
  end

  def create?
    admin_permissions?
  end

  def update?
    admin_permissions?
  end

  def destroy?
    admin_permissions?
  end
end
