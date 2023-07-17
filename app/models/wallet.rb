# frozen_string_literal: true

# wallet model. table: wallets
class Wallet < ApplicationRecord
  belongs_to :typeable, polymorphic: true
  has_many :money
  has_many :transactions

  def balance
    credit = money.pluck(:credit).map(&:to_f).sum
    debit = money.pluck(:debit).map(&:to_f).sum
    credit - debit
  end
end
