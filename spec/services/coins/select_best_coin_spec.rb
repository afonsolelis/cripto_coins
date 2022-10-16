RSpec.describe Coins::SelectBestCoin do
  describe "Service SelectBestCoin" do
    let(:service) { described_class.new }
    before(:each) do
      Coin.delete_all
      CoinHistory.delete_all

      10.times do
        Coin.create!(name: "Coin#{(1..900000).to_a.sample}", last_price: "0.0")
      end

      10.times do
        CoinHistory.create!(coin_id: Coin.all.sample.id, price: "0.0")
      end
    end
    
    it "should return one hash with the best coin and the history of the price of the coins" do
      expect(service.call[:best_coin].count).to eq(10)
      expect(service.call[:history].count).to eq(10)
    end

    it "should return one hash with the best coin on top" do
      chosen_coin = Coin.first
      10.times { |i| CoinHistory.create!(coin_id: chosen_coin.id, price: (100 * i).to_s) }

      expect(service.call[:best_coin][0][:coin]).to eq(chosen_coin.name)
      expect(service.call[:history].count).to eq(10)
    end
  end
end