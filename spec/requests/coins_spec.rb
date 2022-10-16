require 'rails_helper'

RSpec.describe "Coins", type: :request do
  describe "GET /index" do
    let(:coins) { ["BTC", "ETH", "XRP", "BCH", "LTC", "EOS", "XLM", "ADA", "TRX", "XMR"] }

    before(:all) do
      Coin.delete_all
      ["BTC", "ETH", "XRP", "BCH", "LTC", "EOS", "XLM", "ADA", "TRX", "XMR"].each do |coin|
        Coin.create!(name: coin, last_price: "0.0")
      end
    end

    it "should return a 200 status code" do
      get "/coins"
      expect(response.status).to eq(200)
    end

    it "should return a json with all coins" do
      get "/coins"
      returned_coins = response.parsed_body["all_coins"].map { |coin| coin["name"] }
      expect(returned_coins).to eq(coins)
    end
  end
end
