# frozen_string_literal: true

ActiveAdmin.register Admin do
  permit_params :email, :password, :password_confirmation, :role

  index do
    selectable_column
    column :email
    column :role do |admin|
      I18n.t("activerecord.enums.admin.role.#{admin.role}")
    end
    actions
  end

  filter :email
  # filter :role, as: :select, collection: Admin.roles

  form do |f|
    f.inputs do
      f.input :role, collection: Admin.roles.map { |role, _| [I18n.t("activerecord.enums.admin.role.#{role}"), role] }

      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
