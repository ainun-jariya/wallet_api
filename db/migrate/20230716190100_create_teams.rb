# frozen_string_literal: true

# create teams table
class CreateTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :teams do |t|
      t.string :name, unique: true
      t.references :user # for team manager
      t.timestamps
      t.datetime :deleted_at
    end
  end
end
