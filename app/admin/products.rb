# frozen_string_literal: true

ActiveAdmin.register Product do
  permit_params :name_uk,
                :name_ru,
                :drop_shipping_available,
                :inventory_number,
                :price_cents,
                :published,
                :slug,
                :stock_balance,
                :brand_id,
                :preview_uk,
                :preview_ru,
                :description_uk,
                :description_ru,
                :manufacturer_id,
                category_ids: []

  controller do
    def create
      prepare_product_price
      super
    end

    def update
      prepare_product_price
      super
    end

    private

    def prepare_product_price
      PreparePriceParams.call(params.require(:product))
    end
  end

  index download_links: false do
    selectable_column
    column :inventory_number
    column :name_uk
    column :manufacturer
    column :brand
    column :price do |product|
      product.price.format
    end
    column :stock_balance
    column :drop_shipping_available
    column :published
    actions default: true do |product|
      show_in_app_link(product_path(slug: product.slug))
    end
  end

  # TODO: setup name translations filters. They doesn't work right now.
  filter :name_uk
  filter :name_ru
  filter :drop_shipping_available
  filter :inventory_number
  filter :price_cents
  filter :published
  filter :slug
  filter :stock_balance
  filter :brand
  filter :manufacturer
  filter :categories, as: :select,
                      collection: proc { Category.all.map { |c| [c.name, c.id] } },
                      label: I18n.t('active_admin.models.product.filters.labels.categoriy')

  show do
    h1.product.name_uk
    attributes_table do
      row :id
      row :inventory_number
      row :published
      row :manufacturer
      row :brand
      row :name_uk
      row :name_ru
      row :drop_shipping_available
      row :stock_balance
      row :price do |product|
        product.price.format
      end
      row :slug
      row :categories do |product|
        product.categories.map(&:name).join(', ')
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :published
      f.input :inventory_number
      f.input :manufacturer
      f.input :brand
      f.input :name_uk
      f.input :name_ru
      f.input :categories, as: :check_boxes, collection: Category.all
      f.input :price, input_html: { value: FormatPriceInputPlaceholder.call(f.object) },
                      hint: I18n.t('active_admin.defaults.hints.price_format')
      f.input :drop_shipping_available
      f.input :stock_balance
      f.input :slug
      f.input :preview_uk, as: :text
      f.input :preview_ru, as: :text
      f.input :description_uk, as: :text
      f.input :description_ru, as: :text
    end
    f.actions
  end

  action_item :view, only: :show do
    show_in_app_link(product_path(slug: resource.slug))
  end
end
