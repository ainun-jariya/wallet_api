# frozen_string_literal: true

# team model. table: teams
class Team < ApplicationRecord
  has_one :wallet, as: :typeable
  has_many :team_members, name: :members
  has_many :users, through: :members
end
