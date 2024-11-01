# frozen_string_literal: true

ActiveAdmin.register Material do
  config.filters = false

  permit_params :name_uk, :name_ru

  index download_links: false do
    selectable_column
    column :name_uk
    actions
  end

  show do
    h1.material.name_uk
    attributes_table do
      row :name_uk
      row :name_ru
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
