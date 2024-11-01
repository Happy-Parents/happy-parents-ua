# frozen_string_literal: true

# Creates ransack support for mobility virtual translation attributes
module RansackMobilitySearchable
  extend ActiveSupport::Concern

  included do
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
