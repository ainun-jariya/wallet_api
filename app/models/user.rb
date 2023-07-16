# frozen_string_literal: true

# user model. table: users
class User < ApplicationRecord
  default_scope { where(deleted_at: nil) }
  validates_presence_of %i[name email]
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates_format_of :phone, with: /(0|\+)[0-9]{9,15}/, message: 'Phone format invalid'
  has_many :sessions

  def self.login(emaill, password)
    require 'bcrypt'
    user = User.where(email: emaill).first
    user if BCrypt::Password.new(user.password) == password
  end

  class << self
    def generate_password(password)
      require 'bcrypt'
      BCrypt::Password.create(password)
    end
  end
end
