# frozen_string_literal: true

# create stocks table
class CreateStocks < ActiveRecord::Migration[7.0]
  def change
    create_table :stocks do |t|
      t.string :indices
      t.string :identifier
      t.string :symb
      t.integer :number_of_item
      t.references :typeable, polymorphic: { default: 'User' }
      # t.references :user
      t.integer :status
      t.timestamps
    end
  end
end
