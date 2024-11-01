# frozen_string_literal: true

ActiveAdmin.register Country do
  config.filters = false
  permit_params :name_uk, :name_ru

  index download_links: false do
    selectable_column
    column :name_uk
    actions
  end

  show do
    h1.country.name_uk
    attributes_table do
      row :name_uk
      row :name_ru
    end

    table_for country.manufacturers, I18n.t('active_admin.models.country.nested_resources') do
      column I18n.t('active_admin.defaults.nested_resources.attribute') do |manufacturer|
        link_to manufacturer.name, admin_manufacturer_path(manufacturer)
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
