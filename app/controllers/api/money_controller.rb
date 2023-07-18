# frozen_string_literal: true

module Api
  # API for money manipulation
  class MoneyController < ApiController
    before_action :current_user
    before_action :find_wallet
    def cash_in
      money = @wallet.money.new(money_params)
      money.debit = 0
      money.credit = money_params[:amount].to_f
      if money.save
        render json: money, except: %i[deleted_at]
      else
        render json: money.errors, status: 422
      end
    end

    def cash_out
      money = @wallet.money.new(money_params)
      money.debit = money_params[:amount].to_f
      money.credit = 0
      if money.save
        render json: money, except: %i[deleted_at]
      else
        render json: money.errors, status: 422
      end
    end

    private

    def find_wallet
      @wallet = Wallet.find(money_params[:wallet_id])
    end

    def money_params
      params.require(:money).permit(:wallet_id, :amount, :note)
    end
  end
end
