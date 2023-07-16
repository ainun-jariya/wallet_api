# frozen_string_literal: true

# alter user update email & phone to unique
class AddUniqueToEmail < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :email, :string, unique: true
    change_column :users, :phone, :string, limit: 15, unique: true
  end
end
