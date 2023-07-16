# frozen_string_literal: true

# money model. table: money
class Money < ApplicationRecord
  belongs_to :wallet

  const DEBIT = 'debit'
  const CREDIT = 'credit'

  const STATUS_NEW = 0
  const STATUS_OK = 1
end
