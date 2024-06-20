# frozen_string_literal: true

# == Schema Information
#
# Table name: books
#
#  id          :bigint           not null, primary key
#  authors     :string
#  cover_type  :integer          not null
#  language    :integer          not null
#  pages_count :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Book < ApplicationRecord
  include RanSackableAttributable

  validates :cover_type,
            :language,
            :pages_count,
            presence: true

  enum cover_type: { hard: 0, soft: 1 }

  enum language: { uk: 0, eng: 1, ru: 2 }
end
