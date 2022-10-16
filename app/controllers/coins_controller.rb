class CoinsController < ApplicationController
  before_action :set_coins
  def index
    render json: {
      most_valuable_coin: most_valuable_coin,
      all_coins: @coins
    }
  end

  private

  def set_coins
    @coins = Coin.all
  end

  def most_valuable_coin
    @coins.max_by { |coin| coin.last_price.to_f }
  end
end
