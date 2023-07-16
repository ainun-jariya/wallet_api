# frozen_string_literal: true

# create transactions table
class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :product, polymorphic: { default: 'Stock' }
      t.references :wallet
      t.float :debit
      t.float :credit
      t.integer :status
      t.timestamps
      t.datetime :deleted_at
    end
  end
end
