# frozen_string_literal: true

ActiveAdmin.register Skill do
  permit_params :name_uk, :name_ru

  index download_links: false do
    selectable_column
    column :name_uk
    actions
  end

  # TODO: setup filter. It doesn't work right now.
  filter :name_uk

  show do
    h1.skill.name_uk
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
