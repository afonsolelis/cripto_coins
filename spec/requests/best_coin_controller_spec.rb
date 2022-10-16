RSpec.describe BestCoinController do
  describe "GET index" do
    
    before(:all) do
      10.times { Coin.create(name: "BTC#{(1..1000).to_a.sample}", last_price: '0.0') }
    end

    it "should return status 200" do
      get '/best_coin'
      expect(response.code).to eq("200")
    end

    it "assigns @coins" do
      coins = Coin.all
      get '/best_coin'
      expect(response.parsed_body["best_coin"].count).to eq(coins.count)
    end
  end
end