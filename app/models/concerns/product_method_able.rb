# frozen_string_literal: true

# Adds shared common behaviour to all types of products
module ProductMethodAble
  extend ActiveSupport::Concern
  SUFFIXES_TO_EXCLUDE = %w[id type at cents].freeze
  METHODS_TO_ADD = %i[price].freeze

  included do
    product_attributes_methods = ProductAttribute.column_names
                                                 .filter do |col|
      SUFFIXES_TO_EXCLUDE.all? { |suffix| col.exclude?(suffix) }
    end.map(&:to_sym)

    [*product_attributes_methods, *METHODS_TO_ADD].each do |method|
      delegate method, to: :product_attribute
    end
  end
end
