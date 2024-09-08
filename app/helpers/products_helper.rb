# frozen_string_literal: true

# Helpers for products views and layouts
module ProductsHelper
  def formatted_age_range(product)
    range = product.age_range
    return I18n.t('views.products.age_range_baby') if range.to_i == 0

    I18n.t('views.products.age_range', range:)
  end
end
