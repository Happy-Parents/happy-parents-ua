# frozen_string_literal: true

ActiveAdmin.register Book do
  permit_params :authors,
                :cover_type,
                :language,
                :pages_count,
                product_attributes: %i[
                  id
                  name_uk
                  name_ru
                  price_cents
                  published
                  slug
                  inventory_number
                  whearhouse_count
                  drop_shipping_available
                  manufacturer_id
                ]

  index download_links: false do
    selectable_column
    column :inventory_number
    column :name_uk
    column :manufacturer
    column :price do |book|
      book.price.format
    end
    column :whearhouse_count
    column :drop_shipping_available
    column :published
    actions default: true do |book|
      link_to t('active_admin.defaults.actions.show_in_app'),
              book_path(slug: book.slug),
              target: '_blank',
              rel: 'noopener'
    end
  end

  action_item :view, only: :show do
    link_to t('active_admin.defaults.actions.show_in_app'),
            book_path(slug: resource.slug),
            target: '_blank',
            rel: 'noopener'
  end

  action_item :view, only: :index do
    link_to t('active_admin.defaults.actions.show_in_app'),
            books_path,
            target: '_blank',
            rel: 'noopener'
  end

  show title: :name_uk do
    # TODO: add show in app link
    panel 'Product Details' do
      attributes_table_for book.product do
        row :id
        row :inventory_number
        row :name_uk
        row :name_ru
        row :price
        row :published
        row :slug
        row :whearhouse_count
        row :drop_shipping_available
        row :manufacturer
        row :slug
      end
    end
    attributes_table do
      row :id
      row :language
      row :cover_type
      row :pages_count
      row :authors
    end
    # active_admin_comments_for(resource)
  end

  filter :authors
  filter :cover_type, as: :select, collection: Book.cover_types.keys.map { |key| [key.humanize, Book.cover_types[key]] }
  filter :language, as: :select, collection: Book.languages.keys.map { |key| [key.humanize, Book.languages[key]] }
  filter :product_inventory_number, as: :string
  # filter :product_name_uk, as: :string
  # filter :product_name_ru, as: :string
  filter :product_price_cents, as: :numeric
  filter :product_published, as: :select
  filter :product_slug, as: :string
  filter :product_whearhouse_count, as: :numeric
  filter :product_drop_shipping_available, as: :select

  form do |f|
    f.object.errors.messages
    # f.semantic_errors *f.object.errors.messages

    f.inputs 'Book Details' do
      f.input :authors
      f.input :cover_type, as: :select, collection: Book.cover_types.keys
      f.input :language, as: :select, collection: Book.languages.keys
      f.input :pages_count
    end

    f.inputs 'Product Details', for: [:product, f.object.product || Product.new] do |product_form|
      product_form.input :manufacturer
      product_form.input :name_uk
      product_form.input :name_ru
      product_form.input :inventory_number
      # TODO: refactor to price
      product_form.input :price_cents, label: 'Price'
      product_form.input :whearhouse_count, label: 'Warehouse Count'
      product_form.input :drop_shipping_available
      product_form.input :published
    end
    f.inputs 'SEO', for: [:product, f.object.product || Product.new] do |product_form|
      product_form.input :slug
    end

    f.actions
  end
end
