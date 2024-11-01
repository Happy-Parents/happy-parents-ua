# frozen_string_literal: true

ActiveAdmin.register Brand do
  permit_params :name, :manufacturer_id

  index download_links: false do
    selectable_column
    column :name
    actions
  end

  show do
    h3.brand.name
    attributes_table do
      row :manufacturer
      row :name
    end
  end

  filter :name
  filter :manufacturer, collection: proc { Manufacturer.all }
end
