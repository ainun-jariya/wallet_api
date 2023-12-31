# frozen_string_literal: true

# user model. table: sessions
class Session < ApplicationRecord
  default_scope { unscoped }
  belongs_to :user

  class << self
    def generate_token(user)
      require 'sha3'
      s = SHA3::Digest.new(:sha256)
      s << "#{user.id} + #{user.email} + #{Time.now}"
      s.hexdigest
    end
  end
end
