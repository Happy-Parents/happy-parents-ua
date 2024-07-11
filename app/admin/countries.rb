# frozen_string_literal: true

ActiveAdmin.register Country do
  permit_params :name_uk, :name_ru

  index download_links: false do
    selectable_column
    column :name_uk
    actions
  end

  # TODO: setup filter. It doesn't work right now.
  filter :name_uk

  show do
    h1.country.name_uk
    attributes_table do
      row :name_uk
      row :name_ru
    end

    table_for country.manufacturers, 'Виробники' do
      column 'Назва' do |manufacturer|
        link_to manufacturer.name, admin_manufacturer_path(manufacturer)
      end
    end
  end

  form do |f|
    f.input :name_uk
    f.input :name_ru
    f.actions
  end
end
