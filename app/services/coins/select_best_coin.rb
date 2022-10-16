module Coins
  class SelectBestCoin
    def initialize
      @coins = Coin.all
    end

    def call
      coin_history
      response
    end

    private

    def coin_history
      @coin_history = Coin.all.map do |coin|
        prices = CoinHistory.where(coin_id: coin.id).map do |price|
          {
            day: price.created_at,
            price: price.price
          }
        end
        price_history_to_float = prices.map { |data| data[:price].to_f }.last(40)
        {
          coin: coin.name,
          price_history: prices,
          angular_coeficient: Math::AngularCoeficient.new(price_history_to_float).call
        }
      end
      @best_coin = @coin_history.map do |coin|
        { 
          coin: coin[:coin],
          angular_coeficient: coin[:angular_coeficient]
        }
      end.sort_by { |coin| coin[:angular_coeficient] }.reverse
    end
    
    def response
      {
        best_coin: @best_coin,
        history: @coin_history
      }
    end
  end
end