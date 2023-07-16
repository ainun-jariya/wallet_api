# frozen_string_literal: true

module Api
  # API for money manipulation
  class MoneyController < ApplicationController
    def create
      money = Money.new(money_params)
      money.debit = money_params[:amount].to_f if money_params[:type] == Money.DEBIT
      money.credit = money_params[:amount].to_f if money_params[:type] == Money.CREDIT
      if money.save
        money.wallet.save
        render json: money, except: %i[deleted_at password]
      else
        render json: money.errors, status: 422
      end
    end

    private

    def money_params
      params.require(:money).permit(:wallet_id, :amount, :type, :note)
    end
  end
end
