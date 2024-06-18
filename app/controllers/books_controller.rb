# frozen_string_literal: true

# Controller for interacting with book entities
class BooksController < ApplicationController
  def show
    @book = Book.find(params.require(:id))
  end
end
