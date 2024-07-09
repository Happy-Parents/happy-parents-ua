# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id :bigint           not null, primary key
#
class Category < ApplicationRecord
  extend Mobility

  translates :name, type: :string

  has_and_belongs_to_many :books
end
