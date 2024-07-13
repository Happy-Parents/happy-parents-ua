# frozen_string_literal: true

module Resources
  module BookCategories
    # Responsible for selecting book category with associated books for given user logic
    class GetForShowPage
      extend Callable

      def initialize(user:, slug:)
        @user = user
        @slug = slug
      end

      def call
        return category_with_published_books unless access_allowed?

        BookCategory.preload(:books).find_by!(slug:)
      end

      private

      attr_reader :user, :slug

      def category_with_published_books
        BookCategory.eager_load(books: :product)
                    .where(product: { published: true })
                    .find_by!(slug:)
      end

      def access_allowed?
        user && BookCategoryPolicy.new(user, BookCategory.find_by!(slug:))
      end
    end
  end
end
