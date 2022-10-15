# frozen_string_literal: true

require 'httparty'

module Coins
  class Update
    def initialize
      # @coin_names = HTTParty.get('https://www.mercadobitcoin.net/api/coins')
      @coin_names = ['BTC']
    end

    def call
      puts 'Updating coins...'
      @coin_names.each do |coin_name|
        db_coin = Coin.where(name: coin_name).first
        last_price_consulted = coin_last_price_consulted(coin_name)
        Coin.create!(name: coin_name, last_price: last_price_consulted) if db_coin.nil?
        sleep 2
        CoinHistory.create!(coin_id: db_coin.id, price: last_price_consulted)
        db_coin.update(last_price: last_price_consulted)
      end
      puts 'Coins updated!'
    end

    private

    def coin_last_price_consulted(coin_name)
      HTTParty.get("https://www.mercadobitcoin.net/api/#{coin_name}/ticker/")['ticker']['last']
    end
  end
end
