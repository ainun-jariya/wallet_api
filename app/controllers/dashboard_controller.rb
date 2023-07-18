# frozen_string_literal: true

# dashboard view controller
class DashboardController < ApplicationController
  before_action :current_user
  before_action :find_wallet, :find_stocks, :ins_outs, :find_transactions

  def index; end

  private

  def find_wallet
    @wallet = @current_user.wallet
  end

  def find_stocks
    @stocks = @current_user.stocks
  end

  def ins_outs
    @ins_outs = @current_user.wallet.money
  end

  def find_transactions
    @transactions = @current_user.wallet.transactions
  end
end
