# frozen_string_literal: true

class Coin < ApplicationRecord
  has_many :coin_prices

  validates :name, presence: true, uniqueness: true
  validates :last_price, presence: true
end
