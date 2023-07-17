# frozen_string_literal: true

module Api
  # API for user/team stock manipulation
  class TransactionsController < ApplicationController
    before_action :current_user
    before_action :find_wallet, :find_stock

    def buy
      render json: 'Not enough money', status: 422 if @wallet.balance < transaction_params[:amount].to_f
      @stock_params = transaction_params[:stock]
      transaction = @wallet.transactions.new(
        debit: transaction_params[:amount].to_f,
        status: Transaction::STATUS_OK,
        product_type: 'Stock')
      if transaction.save
        @wallet.money.create({ debit: transaction_params[:amount].to_f, credit: 0 })
        if @stock.present?
          @stock.number_of_item += @stock_params[:number_of_item].to_i
          @stock.save
        else
          @stock = Stock.create(@stock_params)
          transaction.update(product_id: @stock.id)
        end
        render json: transaction, except: %i[deleted_at]
      else
        render json: transaction.errors, status: 422
      end
    end

    def sell
      @stock_params = transaction_params[:stock]
      render json: 'You have less stock', status: 422 if @stock.number_of_item < @stock_params[:number_of_item].to_i
      transaction = @stock.transactions.new(
        wallet_id: transaction_params[:wallet_id],
        credit: transaction_params[:amount].to_f,
        status: Transaction::STATUS_OK,
        product_type: 'Stock'
      )
      transaction.credit = transaction_params[:amount].to_f
      if transaction.save
        @wallet.money.create({ debit: 0, credit: transaction_params[:amount].to_f })
        if @stock.present?
          @stock.number_of_item -= @stock_params[:number_of_item].to_i
          if @stock.number_of_item.zero?
            @stock.soft_destroy
          else
            @stock.save
          end
        end
        render json: transaction, except: %i[deleted_at]
      else
        render json: transaction.errors, status: 422
      end
    end

    private

    def find_wallet
      @wallet = Wallet.find(transaction_params[:wallet_id])
    rescue ActiveRecord::RecordNotFound
      render json: 'Wallet not found', status: 422
    end

    def find_stock
      @stock = Stock.where(transaction_params[:stock].except(:number_of_item)).first
    rescue ActiveRecord::RecordNotFound
      render json: 'Stock not found', status: 422
    end

    def transaction_params
      params.require(:transaction).permit(:wallet_id, :amount, :product_id,
                                          stock: %i[indices identifier symb number_of_item])
    end
  end
end
