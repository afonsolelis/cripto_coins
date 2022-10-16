# frozen_string_literal: true

class BestCoinController < ApplicationController
  def index
    render json: Coins::SelectBestCoin.new.call
  end
end
