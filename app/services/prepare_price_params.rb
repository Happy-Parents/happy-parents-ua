# frozen_string_literal: true

# Responsible for preparing price paramater in product create/update form in admin panel
module PreparePriceParams
  def self.call(product_attrs)
    specifications_params = product_attrs[:specifications]

    product_attrs[:specifications] = JSON.parse(specifications_params) if specifications_params.present?

    product_attrs
  end
end
