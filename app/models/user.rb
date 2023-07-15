# frozen_string_literal: true

# user model. table: users
class User < ApplicationRecord
  validates_presence_of %i[name email]
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates_format_of :phone, with: /(0|\+)[0-9]{9,15}/, message: 'Phone format invalid'
end
