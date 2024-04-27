# frozen_string_literal: true

# == Schema Information
#
# Table name: admins
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_admins_on_email                 (email) UNIQUE
#  index_admins_on_reset_password_token  (reset_password_token) UNIQUE
#
# Represents application administrator entity
class Admin < ApplicationRecord
  include RanSackableAttributable

  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  validates :role, :password, presence: true
  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: URI::MailTo::EMAIL_REGEXP }

  enum role: { superadmin: 0, manager: 1 }
end
