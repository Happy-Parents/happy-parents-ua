# frozen_string_literal: true

# Represents product manufacturer entity
ActiveAdmin.register Manufacturer do
  permit_params :name, :country_id

  index download_links: false do
    selectable_column
    column :name
    actions
  end

  filter :name
  filter :country, collection: proc { Country.all }
end
