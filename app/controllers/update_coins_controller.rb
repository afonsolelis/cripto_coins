# frozen_string_literal: true

require 'httparty'

class UpdateCoinsController < ApplicationController
  def index
    Coins::Update.new.call
    coins = Coin.all.map { |coin| { name: coin.name, last_price: coin.last_price.to_f } }
    render json: coins.sort_by { |coin| -coin[:last_price] }
  end
end
