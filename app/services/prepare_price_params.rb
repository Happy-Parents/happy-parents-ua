# frozen_string_literal: true

# Responsible for preparing price paramater in product create/update form in admin panel
module PreparePriceParams
  def self.call(product_attrs)
    price_params = product_attrs['price']

    if price_params.present?
      product_attrs['price_cents'] = Actions::PriceToCents.call(price_params)
      product_attrs.delete('price')
    end

    product_attrs
  end
end
