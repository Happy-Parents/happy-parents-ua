# frozen_string_literal: true

ActiveAdmin.register BookCategory do
  permit_params :slug, :name_uk, :name_ru

  index do
    selectable_column
    column :name_uk
    # actions name: I18n.t('active_admin.defaults.column_titles.actions')
    actions default: true do |book_category|
      show_in_app_link(book_category_path(slug: book_category.slug))
    end
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

  action_item :view, only: :index do
    show_in_app_link(book_categories_path)
  end

  action_item :view, only: :show do
    show_in_app_link(book_category_path(slug: resource.slug))
  end

  show do
    attributes_table do
      row :id
      row :slug
      row :name_uk
      row :name_ru
    end
    # active_admin_comments
    table_for book_category.books, 'Книги' do
      column 'Назва' do |book|
        link_to(book.name_uk, admin_book_path(book))
      end
    end
  end
end
