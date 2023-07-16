# frozen_string_literal: true

# create team_members table
class CreateTeamMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :team_members do |t|
      t.references :user
      t.references :team
      t.timestamps
      t.datetime :deleted_at
    end
  end
end
