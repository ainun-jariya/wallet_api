# frozen_string_literal: true

# create sessions table
class CreateSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :sessions do |t|
      t.string :token
      t.references :user
      t.string :device
      t.timestamps
    end
  end
end
