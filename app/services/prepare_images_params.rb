# frozen_string_literal: true

# Responsible for preparing images paramater in product update form in admin panel
module PrepareImagesParams
  def self.call(params)
    product = Product.find(params[:id])
    product_attrs = params.require(:product)

    if product.images.present? && params[:product][:images].reject { |item| item == '' }.blank?
      product_attrs.delete(:images)
    end

    product_attrs
  end
end
