require 'rails_helper'

RSpec.describe CoinHistory, :type => :model do
  let(:coin) { Coin.create!(name: 'Coin', last_price: '0.0') }

  it "is valid with valid attributes" do
    expect(CoinHistory.new(price: '0.0', coin_id: coin.id)).to be_valid
  end
  it "is not valid without a price" do
    expect(CoinHistory.new(price: '', coin_id: coin.id)).to_not be_valid
  end
  it "is not valid without a coin" do
    expect(CoinHistory.new(price: '0.0', coin_id: nil)).to_not be_valid
  end
end