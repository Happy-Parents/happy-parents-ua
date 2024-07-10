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
                ],
                category_ids: []

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
      show_in_app_link(book_path(slug: book.slug))
    end
  end

  action_item :view, only: :show do
    show_in_app_link(book_path(slug: resource.slug))
  end

  action_item :view, only: :index do
    show_in_app_link(books_path)
  end

  show title: :name_uk do
    panel 'Деталі товару' do
      attributes_table_for book.product do
        row :id
        row :inventory_number
        row :name_uk
        row :name_ru
        row :price do |book|
          book.price.format
        end
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
      row :language do |book|
        enum_translation(:book, :language, book.language)
      end
      row :cover_type do |book|
        enum_translation(:book, :cover_type, book.cover_type)
      end
      row :pages_count
      row :authors
      row :categories do |book|
        safe_join(book.categories.map(&:name_uk), ', ')
      end
    end
    # TODO: add admin comments
    # active_admin_comments_for(resource)
  end

  filter :authors
  filter :cover_type, as: :select, # -
                      collection: Book.cover_types.keys.map do |key|
    [I18n.t("activerecord.enums.book.cover_type.#{key}"), key]
  end
  filter :language, as: :select, # -
                    collection: Book.languages.keys.map do |key|
    [I18n.t("activerecord.enums.book.language.#{key}"), key]
  end
  filter :product_inventory_number, as: :string
  # TODO: add translation name filters
  # filter :name_uk, as: :string, collection: proc { Product.all.map(&:name_uk) }
  # filter :product_name_ru, as: :string
  filter :product_price_cents, as: :numeric
  filter :product_published, as: :select
  filter :product_slug, as: :string
  filter :product_whearhouse_count, as: :numeric
  filter :product_drop_shipping_available, as: :select

  form do |f|
    f.object.errors.messages
    # TODO: debug and add error messages
    # f.semantic_errors *f.object.errors.messages

    f.inputs 'Атрибути книги' do
      f.input :authors
      f.input :cover_type, as: :select, collection: translated_collection('book', 'cover_type')
      f.input :language, as: :select, collection: translated_collection('book', 'language')
      f.input :pages_count
      f.input :categories, as: :check_boxes
    end

    f.inputs 'Деталі товару', for: [:product, f.object.product || Product.new] do |product_form|
      product_form.input :manufacturer
      product_form.input :name_uk
      product_form.input :name_ru
      product_form.input :inventory_number
      product_form.input :price, input_html: { value: formatted_price_input(object) },
                                 hint: I18n.t('active_admin.defaults.hints.price_format')

      product_form.input :whearhouse_count
      product_form.input :drop_shipping_available
      product_form.input :published
    end
    f.inputs 'SEO', for: [:product, f.object.product || Product.new] do |product_form|
      product_form.input :slug
    end

    f.actions
  end
  controller do
    def create
      prepare_product_params
      super
    end

    def update
      prepare_product_params
      super
    end

    private

    def prepare_product_params
      product_attributes[:price_cents] = Store::PriceToCents.call(product_attributes.require(:price))
      product_attributes.delete(:price)
    end

    def product_attributes
      params.require(:book).require(:product_attributes)
    end
  end
end
