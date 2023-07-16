# frozen_string_literal: true

# create users table
class CreateUsersTable < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :phone, limit: 15
      t.timestamps
      t.datetime :deleted_at
    end
  end
end
