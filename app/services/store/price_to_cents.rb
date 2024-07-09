# frozen_string_literal: true

module Store
  # Responsible for converting price input to price_cents int value
  class PriceToCents
    extend Callable

    CURRENCY_SIGN = ' ₴'
    OUPUT_FOR_INVALID_INPUT = 0

    def initialize(price)
      @price = price
    end

    def call
      parsed_result || OUPUT_FOR_INVALID_INPUT
    end

    private

    def parsed_result
      case price_value.split('.').length
      when 1
        parsed_integer_cents
      when 2
        parsed_float
      else
        OUPUT_FOR_INVALID_INPUT
      end
    end

    def parsed_integer_cents
      Integer(price_value) * 100
    rescue TypeError, ArgumentError
      nil
    end

    def parsed_float
      # binding.irb
      Integer(price_value.delete('.'))
    rescue TypeError, ArgumentError
      nil
    end

    def price_value
      @price_value ||= @price.to_s.delete(CURRENCY_SIGN)
    end
  end
end
