# frozen_string_literal: true

# wallet model. table: wallets
class Wallet < ApplicationRecord
  belongs_to :user, source: :typeable, source_type: User, optional: true
  belongs_to :team, source: :typeable, source_type: Team, optional: true
  has_many :money
  has_many :transactions
end
