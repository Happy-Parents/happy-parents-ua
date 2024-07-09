# frozen_string_literal: true

ActiveAdmin.register Category do
  permit_params :slug, :name_uk, :name_ru

  index do
    selectable_column
    id_column
    column :name_uk
    actions
  end

  filter :slug
  filter :name_uk
  filter :name_ru

  form do |f|
    f.inputs do
      f.input :slug
      f.input :name_uk
      f.input :name_ru
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :slug
      row :name_uk
      row :name_ru
    end
    # active_admin_comments
  end
end
