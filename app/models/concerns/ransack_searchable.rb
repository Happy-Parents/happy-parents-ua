# frozen_string_literal: true

# Ransack needs Model attributes explicitly allowlisted as searchable.
# Define a `ransackable_attributes` class method in your model.
# ----------
# Try to remove this after ActiveAdmin update
module RansackSearchable
  extend ActiveSupport::Concern

  included do
    def self.ransackable_attributes(_auth_object = nil)
      authorizable_ransackable_attributes
    end

    def self.ransackable_associations(_auth_object = nil)
      authorizable_ransackable_associations
    end

    # Creates ransack support for mobility virtual translation attributes
    I18n.available_locales.each do |locale|
      ransacker "name_#{locale}" do |_parent|
        Arel::Nodes::SqlLiteral.new(
          '(SELECT value FROM mobility_string_translations ' \
          "WHERE translatable_id = products.id AND key = 'name' AND locale = '#{locale}')"
        )
      end
    end
  end
end
