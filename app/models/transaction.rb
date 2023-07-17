# frozen_string_literal: true

# transaction model. table: transactions
class Transaction < ApplicationRecord
  belongs_to :wallet
  alias_attribute :amount, :debit # first initialization

  DEBIT = 'debit'
  CREDIT = 'credit'

  STATUS_NEW = 0
  STATUS_OK = 1
end
