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

    panel 'Торгівельні марки' do
      table_for manufacturer.trade_marks do
        column 'Назва' do |trade_mark|
          link_to trade_mark.name, admin_trade_mark_path(trade_mark)
        end
      end
    end
  end

  filter :name
  filter :country, collection: proc { Country.all }
end
