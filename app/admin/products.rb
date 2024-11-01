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
                images: [],
                category_ids: [],
                skill_ids: [],
                specifications: {}

  controller do
    before_action :prepare_create_params, only: :create
    before_action :prepare_update_params, only: :update

    def delete_image
      product = DeleteProductImage.call(**delete_params)

      redirect_back fallback_location: edit_admin_product_path(product),
                    notice: 'Зображення видалено.'
    end

    private

    def prepare_create_params
      PrepareSpecificationsParams.call(product_attrs)
      PreparePriceParams.call(product_attrs)
    end

    def prepare_update_params
      PrepareSpecificationsParams.call(product_attrs)
      PreparePriceParams.call(product_attrs)
      PrepareImagesParams.call(params)
    end

    def product_attrs
      params.require(:product)
    end

    def delete_params
      {
        id: params.require(:id),
        image_id: params.require(:image_id)
      }
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
      row :images do
        div style: 'display: flex; flex-wrap: wrap;' do
          product.thumbnails.each do |thumb|
            div style: 'margin-right: 10px; text-align: center;' do
              div do
                image_tag url_for(thumb), style: 'height: 50px; width: auto;'
              end
              div do
                link_to 'Завантажити', rails_blob_path(thumb.blob, disposition: 'attachment'), class: 'download-link'
              end
            end
          end
        end
      end
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

      # Показуємо існуючі зображення з можливістю їх видалити
      if f.object.images.attached?
        div style: 'display: flex; flex-wrap: wrap; gap: 10px;' do
          f.object.thumbnails.each_with_index do |thumb, _index|
            div style: 'display: inline-block; margin-right: 10px; text-align: center;' do
              div do
                image_tag(url_for(thumb), style: 'height: 50px; width: auto; margin-bottom: 5px;')
              end
              div do
                link_to 'Видалити', delete_image_admin_product_path(f.object, image_id: thumb.blob.id),
                        method: :delete,
                        data: { confirm: 'Видалити зображення?' }
              end
            end
          end
        end
      end

      f.input :images, as: :file, input_html: { multiple: true }, hint: 'Вибір нових замінює існуючі'
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
