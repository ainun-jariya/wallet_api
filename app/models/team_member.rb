# frozen_string_literal: true

# team member model. table: team_members
class TeamMember < ApplicationRecord
  belongs_to :team
  belongs_to :user
end
