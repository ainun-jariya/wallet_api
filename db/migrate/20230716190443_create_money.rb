# frozen_string_literal: true

# create money table
class CreateMoney < ActiveRecord::Migration[7.0]
  def change
    create_table :money do |t|
      t.references :wallet
      t.float :debit
      t.float :credit
      t.string :note
      t.timestamps
      t.datetime :deleted_at
    end
  end
end
