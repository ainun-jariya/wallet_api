# frozen_string_literal: true

# team model. table: teams
class Team < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :name
  has_one :wallet, as: :typeable
  has_many :team_members
  has_many :users, through: :members
end
