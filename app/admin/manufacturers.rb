# frozen_string_literal: true

# Represents product manufacturer entity
ActiveAdmin.register Manufacturer do
  permit_params :name, :country_id

  index download_links: false do
    selectable_column
    column :name
    actions
  end

  show do
    h3.manufacturer.name
    attributes_table do
      row :name
    end

    # TODO: I18n
    panel 'Торгівельні марки' do
      table_for manufacturer.brands do
        column 'Назва' do |brand|
          link_to brand.name, admin_brand_path(brand)
        end
      end
    end
  end

  filter :name
  filter :country, collection: proc { Country.all }
end
