# frozen_string_literal: true

module Api
  # API for user/team stock manipulation
  class TransactionsController < ApplicationController
    def buy
      # check money first
      transaction = Transaction.new(transaction_params)
      wallet = Wallet.find(transaction_params[:wallet_id].to_i)
      transaction.debit = transaction_params[:amount].to_f
      if transaction.save
        wallet.money.create({ debit: transaction_params[:amount].to_f, credit: 0, status: Money.STATUS_OK })
        stock = Stock.where(stock_params.except(:number_of_item)).first
        if stock.present?
          stock.number_of_item += stock_params[:number_of_item].to_i
          stock.save
        else
          Stock.create(stock_params)
        end
        render json: transaction, except: %i[deleted_at]
      else
        render json: transaction.errors, status: 422
      end
    end

    def sell
      # check if stock and number of item to sell is aligned
      transaction = Transaction.new(transaction_params)
      wallet = Wallet.find(transaction_params[:wallet_id].to_i)
      transaction.credit = transaction_params[:amount].to_f
      if transaction.save
        wallet.money.create({ debit: 0, credit: transaction_params[:amount].to_f, status: Money.STATUS_OK })
        stock = Stock.where(stock_params.except(:number_of_item)).first
        if stock.present?
          stock.number_of_item -= stock_params[:number_of_item].to_i
          if stock.number_of_item.zero?
            stock.soft_destroy
          else
            stock.save
          end
        end
        render json: transaction, except: %i[deleted_at password]
      else
        render json: transaction.errors, status: 422
      end
    end

    private

    def transaction_params
      params.require(:transaction).permit(:wallet_id, :amount, :product_id)
    end

    def stock_params
      params.require(:stock).permit(:wallet_id, :indices, :identifier, :symb, :number_of_item)
    end
  end
end
