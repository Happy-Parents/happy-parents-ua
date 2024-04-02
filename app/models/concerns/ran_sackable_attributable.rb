# frozen_string_literal: true

# Ransack needs Model attributes explicitly allowlisted as searchable.
# Define a `ransackable_attributes` class method in your model.
# ----------
# Try to remove this after ActiveAdmin update
module RanSackableAttributable
  extend ActiveSupport::Concern
  class_methods do
    def ransackable_attributes(_auth_object = nil)
      columns.map(&:name)
    end
  end
end
