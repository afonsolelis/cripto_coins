class CoinsController < ApplicationController
  before_action :set_coins
  def index
    render json: {
      coins: @coins
    }
  end

  private

  def set_coins
    @coins = Coin.all.map do |coin|
      { name: coin.name, last_price: coin.last_price.to_f }
    end.sort_by! { |coin| -coin[:last_price] }
  end
end
