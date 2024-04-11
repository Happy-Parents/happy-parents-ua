# frozen_string_literal: true

ActiveAdmin.register Admin do
  permit_params :email, :password, :password_confirmation, :role

  index do
    selectable_column
    column :email
    column :role
    actions
  end

  filter :email
  # filter :role, as: :select, collection: Admin.roles

  form do |f|
    f.inputs do
      f.input :role
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
