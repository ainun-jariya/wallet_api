# frozen_string_literal: true

# user model. table: users
class User < ApplicationRecord
  validates_presence_of %i[name email]
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates_format_of :phone, with: /(0|\+)[0-9]{9,15}/, message: 'Phone format invalid'
  validates_uniqueness_of :email
  validates_uniqueness_of :phone
  has_many :sessions
  has_one :wallet, as: :typeable
  has_many :team_members
  has_many :teams, through: :team_members
  has_many :stocks, as: :typeable

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
