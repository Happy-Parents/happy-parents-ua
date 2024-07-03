# frozen_string_literal: true

module ActiveAdmin
  # ActiveAdmin General helper methods
  # TODO: add tests for helpers
  module ViewsHelper
    def show_in_app_link(url)
      link_to t('active_admin.defaults.actions.show_in_app'),
              url,
              target: '_blank',
              rel: 'noopener'
    end

    def enum_translation(model, enum, key)
      I18n.t("activerecord.enums.#{model}.#{enum}.#{key}")
    end

    def translated_collection(model, enum)
      model.capitalize
           .constantize
           .public_send(enum.pluralize.to_sym).keys.map do |key|
        [enum_translation(model, enum, key), key]
      end
    end

    def formatted_price_input(entity)
      return form_input_price_format(entity.price) if entity.product

      form_input_price_format(Money.new(0))
    end

    def form_input_price_format(money_object)
      number_with_precision(money_object, precision: 2, delimiter: ' ', separator: '.')
    end
  end
end
