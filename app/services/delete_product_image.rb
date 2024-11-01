# frozen_string_literal: true

# Responsible for deleting product image logic
module DeleteProductImage
  def self.call(id:, image_id:)
    product = Product.find(id)
    product.images.find(image_id).purge
    product
  end
end
