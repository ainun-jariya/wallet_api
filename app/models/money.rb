# frozen_string_literal: true

# money model. table: money
class Money < ApplicationRecord
  belongs_to :wallet
  # attr_accessor :wallet_id, :debit, :credit, :note

  alias_attribute :amount, :debit # first initialization

  DEBIT = 'debit'
  CREDIT = 'credit'
end
