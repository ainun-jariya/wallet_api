# frozen_string_literal: true

module Api
  # API for team manipulation
  class TeamsController < ApiController
    before_action :current_user, only: %i[show create update destroy add_members]
    before_action :find_team, only: %i[show update destroy add_members]

    def index
      render json: Team.all, except: %i[deleted_at]
    end

    def show
      render json: @team, except: %i[deleted_at]
    end

    def create
      @team = Team.new(team_params)
      @team.user_id = @current_user.id
      if @team.save
        @team.team_members.create({ team_id: @team.id, user_id: @current_user.id })
        @team.wallet.save
        render json: @team, except: %i[deleted_at]
      else
        render json: @team.errors, status: 422
      end
    end

    def update
      if @team.update(team_params)
        render json: @team, except: %i[deleted_at]
      else
        render json: @team.errors, status: 422
      end
    rescue ActiveRecord::RecordNotFound
      render json: { message: 'Team not found' }.to_json, status: 404
    end

    def destroy
      @team.team_members.update(deleted_at: Time.now)
      @team.wallet.soft_destroy
      @team.soft_destroy

      render json: { message: 'Team has been deleted' }.to_json, status: 200
    rescue ActiveRecord::RecordNotFound
      render json: { message: 'Team not found' }.to_json, status: 404
    end

    def add_members
      existing_user_ids = @team.team_members.where(user_id: params[:member][:user_ids].map(&:to_i)).pluck(:user_id)
      users = User.where(id: (params[:member][:user_ids].map(&:to_i) - existing_user_ids))
      users.each do |user|
        @team.team_members.insert({ team_id: @team.id, user_id: user.id })
      end
      render json: @team, except: %i[deleted_at]
    end

    private

    def find_team
      @team = Team.find(params[:id].to_i)
    rescue ActiveRecord::RecordNotFound
      render json: { message: 'Team not found' }.to_json, status: 404
    end

    def team_params
      params.require(:team).permit(:name)
    end

    def member_params
      params.require(:member).permit(:user_ids)
    end
  end
end
