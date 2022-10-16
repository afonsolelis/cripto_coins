class CoinsController < ApplicationController
  def index
    render json: {
      most_valuable_coin: most_valuable_coin,
      all_coins: Coin.all
    }
  end

  private

  def most_valuable_coin
    Coin.all.max_by { |coin| coin.last_price.to_f }
  end
end
