# frozen_string_literal: true

ActiveAdmin.register Book do
  permit_params :manufacturer_id,
                :name_uk,
                :name_ru,
                :slug,
                :cover_type,
                :language,
                :pages_count,
                :authors,
                :price_cents,
                :whearhouse_count,
                :drop_shipping_available,
                :published

  index download_links: false do
    selectable_column
    column :name_uk
    column :language do |book|
      I18n.t("activerecord.enums.book.language.#{book.language}")
    end
    column :manufacturer
    column :whearhouse_count
    column :price_cents do |book|
      book.price.format
    end
    column :drop_shipping_available
    column :published
    actions default: true do |book|
      link_to t('active_admin.defaults.actions.show_in_app'), book_path(id: book.id), target: '_blank',
                                                                                      rel: 'noopener'
    end
  end

  show do
    h1.book.name
    attributes_table do
      row :manufacturer
      row :name_uk
      row :name_ru
      row :slug
      row :cover_type do |book|
        I18n.t("activerecord.enums.book.cover_type.#{book.cover_type}")
      end
      row :language do |book|
        I18n.t("activerecord.enums.book.language.#{book.language}")
      end
      row :pages_count
      row :authors
      row :price do |book|
        book.price.format
      end
      row :whearhouse_count
      row :drop_shipping_available
      row :published
    end
  end

  action_item :view, only: :show do
    link_to t('active_admin.defaults.actions.show_in_app'), book_path(id: book.id), target: '_blank',
                                                                                    rel: 'noopener'
  end

  filter :manufacturer
  filter :name_uk
  filter :name_ru
  filter :slug
  filter :cover_type, as: :select, collection: Book.cover_types.keys.map { |k|
                                                 [I18n.t("activerecord.enums.book.cover_type.#{k}"), k]
                                               }
  filter :language, as: :select, collection: Book.languages.keys.map { |k|
                                               [I18n.t("activerecord.enums.book.language.#{k}"), k]
                                             }
  filter :pages_count
  filter :authors
  filter :price_cents
  filter :whearhouse_count
  filter :drop_shipping_available
  filter :published

  form do |f|
    f.semantic_errors(*f.object.errors.attribute_names)
    tabs do
      tab 'Продукт' do
        f.inputs do
          f.input :name_uk
          f.input :name_ru
          # TODO: refactor :price to save :price_cents instead of using controller. Vay be try to access f.object
          f.input :price
          f.input :whearhouse_count
          f.input :drop_shipping_available
          f.input :published
        end
      end

      tab 'Книга' do
        f.inputs  do
          f.input :manufacturer
          f.input :authors
          f.input :pages_count

          f.input :cover_type, as: :select, collection: Book.cover_types.keys.map { |k|
                                                          [I18n.t("activerecord.enums.book.cover_type.#{k}"), k]
                                                        }
          f.input :language, as: :select, collection: Book.languages.keys.map { |k|
                                                        [I18n.t("activerecord.enums.book.language.#{k}"), k]
                                                      }
        end
      end

      tab 'SEO' do
        f.inputs do
          f.input :slug
        end
      end
    end
    f.actions
  end

  controller do
    # def find_resource
    #   scoped_collection.friendly.find(params[:id])
    # end

    # NOTE: works with kind of bug when submitting not a number value
    def update
      # TODO: move this logic to service object
      return unless params.dig(:book, :price)

      params[:book][:price_cents] = params.require(:book).require(:price).delete(',').to_i
      params[:book].delete(:price)
      super
    end
  end
end
