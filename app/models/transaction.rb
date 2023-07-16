# frozen_string_literal: true

# transaction model. table: transactions
class Transaction < ApplicationRecord
  belongs_to :wallet

  const DEBIT = 'debit'
  const CREDIT = 'credit'

  const STATUS_NEW = 0
  const STATUS_OK = 1
end
