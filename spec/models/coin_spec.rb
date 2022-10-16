require 'rails_helper'

RSpec.describe Coin, :type => :model do
  it "is valid with valid attributes" do
    expect(Coin.new(name: 'Coin', last_price: '0.0')).to be_valid
  end
  it "is not valid without a name" do
    expect(Coin.new(name: '', last_price: '0.0')).to_not be_valid
  end
  it "is not valid without a last_price" do
    expect(Coin.new(name: 'Coin', last_price: '')).to_not be_valid
  end

  it "must have a unique name" do
    Coin.create!(name: 'UniqueName', last_price: '0.0')
    expect do
      Coin.create!(name: 'UniqueName', last_price: '0.0')
    end.to raise_error(ActiveRecord::RecordInvalid)
  end
end