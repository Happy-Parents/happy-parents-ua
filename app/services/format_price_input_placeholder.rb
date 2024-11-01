# frozen_string_literal: true

# Responsible for formatting price value at admin panel form
# TODO: add tests | Problem: encoding
class FormatPriceInputPlaceholder
  extend Callable

  def initialize(product)
    @product = product
  end

  def call
    ActionController::Base.helpers.number_with_precision(money_object, precision: 2, delimiter: ' ', separator: '.')
  end

  private

  attr_reader :product

  def money_object
    product&.price || Money.new(0)
  end
end
