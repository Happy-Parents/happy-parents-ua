# frozen_string_literal: true

# Ransack needs Model attributes explicitly allowlisted as searchable.
# Define a `ransackable_attributes` class method in your model.
# ----------
# Try to remove this after ActiveAdmin update
module RanSackableAttributable
  extend ActiveSupport::Concern

  included do
    def self.ransackable_attributes(_auth_object = nil)
      authorizable_ransackable_attributes
    end

    def self.ransackable_associations(_auth_object = nil)
      authorizable_ransackable_associations
    end
  end
end
