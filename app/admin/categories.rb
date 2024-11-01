# frozen_string_literal: true

ActiveAdmin.register Category do
  permit_params :name_uk, :name_ru

  index download_links: false do
    selectable_column
    column :name_uk
    actions
  end

  filter :name_uk

  show do
    h1.category.name_uk
    attributes_table do
      row :name_uk
      row :name_ru
    end

    table_for category.products, I18n.t('active_admin.models.category.nested_resources') do
      column I18n.t('active_admin.defaults.nested_resources.attribute') do |product|
        link_to product.name_uk, admin_manufacturer_path(product)
      end
    end
  end

  form do |f|
    inputs do
      f.input :name_uk
      f.input :name_ru
    end
    f.actions
  end
end
