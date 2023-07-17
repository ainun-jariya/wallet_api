# frozen_string_literal: true

# create wallets table
class CreateWallets < ActiveRecord::Migration[7.0]
  def change
    create_table :wallets do |t|
      t.references :typeable, polymorphic: { default: 'User' }
      # t.references :user
      t.timestamps
      t.datetime :deleted_at
    end
  end
end
