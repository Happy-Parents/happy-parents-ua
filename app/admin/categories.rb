# frozen_string_literal: true

ActiveAdmin.register Category do
  permit_params :slug, :name_uk, :name_ru

  index do
    selectable_column
    column :name_uk
    actions name: I18n.t('active_admin.defaults.column_titles.actions')
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
