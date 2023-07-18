# frozen_string_literal: true

# stock model. table: stocks
class Stock < ApplicationRecord
  has_many :transactions, as: :product
  belongs_to :typeable, polymorphic: true
end
