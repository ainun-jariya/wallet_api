# frozen_string_literal: true

module Api
    # API for wallet manipulation
    class WalletsController < ApplicationController
      def index
        render json: Wallet.all, except: %i[deleted_at]
      end
  
      def show
        render json: Wallet.find(params[:id]), except: %i[deleted_at]
      rescue ActiveRecord::RecordNotFound
        render json: { message: 'Wallet not found' }.to_json, status: 404
      end
  
      def create
        wallet = Wallet.new(wallet_params)
        if wallet.save
          render json: wallet, except: %i[deleted_at password]
        else
          render json: wallet.errors, status: 422
        end
      end
  
      def update
        wallet = Wallet.find(params[:id])
        if wallet.update(wallet_params)
          render json: wallet, except: %i[deleted_at password]
        else
          render json: wallet.errors, status: 422
        end
      rescue ActiveRecord::RecordNotFound
        render json: { message: 'Wallet not found' }.to_json, status: 404
      end
  
      def destroy
        wallet = Wallet.find(params[:id])
        wallet.soft_destroy
  
        render json: { message: 'Wallet has been deleted' }.to_json, status: 200
      rescue ActiveRecord::RecordNotFound
        render json: { message: 'Wallet not found' }.to_json, status: 404
      end
  
      private
  
      def wallet_params
        params.require(:wallet).permit(:name, :email, :phone, :password)
      end
    end
  end
  