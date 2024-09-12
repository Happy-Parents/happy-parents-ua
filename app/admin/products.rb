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
                :material_id,
                :age_range,
                :gender_target,
                category_ids: [],
                skill_ids: [],
                specifications: {}

  controller do
    before_action :prepare_params, only: %i[create update]

    private

    def prepare_params
      product_attrs = params.require(:product)
      PrepareSpecificationsParams.call(product_attrs)
      PreparePriceParams.call(product_attrs)
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
  filter :material
  filter :categories, as: :select, collection: proc { Category.all.map { |c| [c.name, c.id] } }
  filter :skills, as: :select, collection: proc { Skill.all.map { |s| [s.name, s.id] } }
  filter :age_range, as: :select,
                     collection: proc {
                                   Product.age_ranges.keys.map do |key|
                                     enum_translation(:product, :age_range, key)
                                   end
                                 }
  filter :gender_target, as: :select,
                         collection: proc {
                                       Product.gender_targets.keys.map do |key|
                                         enum_translation(:product, :gender_target, key)
                                       end
                                     }

  show do
    h1.product.name_uk
    attributes_table do
      row :id
      row :inventory_number
      row :published
      row :manufacturer
      row :material
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
      row :skills do |_skill|
        product.skills.map(&:name).join(', ')
      end
      row :age_range do |product|
        enum_translation(:product, :age_range, product.age_range)
      end
      row :gender_target do |product|
        enum_translation(:product, :gender_target, product.gender_target)
      end
      row :specifications
    end
  end

  form do |f|
    f.inputs do
      f.input :published
      f.input :inventory_number
      f.input :manufacturer
      f.input :material
      f.input :brand
      f.input :name_uk
      f.input :name_ru
      f.input :categories, as: :check_boxes, collection: Category.all
      f.input :skills, as: :check_boxes, collection: Skill.all
      f.input :age_range, collection: translated_collection('product', 'age_range')
      f.input :gender_target, collection: translated_collection('product', 'gender_target')
      f.input :price, input_html: { value: FormatPriceInputPlaceholder.call(f.object) },
                      hint: I18n.t('active_admin.defaults.hints.price_format')
      f.input :drop_shipping_available
      f.input :stock_balance
      f.input :slug
      f.input :preview_uk, as: :text
      f.input :preview_ru, as: :text
      f.input :description_uk, as: :text
      f.input :description_ru, as: :text
      f.input :specifications, as: :jsonb
    end
    f.actions
  end

  action_item :view, only: :show do
    show_in_app_link(product_path(slug: resource.slug))
  end
end
