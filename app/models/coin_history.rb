# frozen_string_literal: true

class CoinHistory < ApplicationRecord
  belongs_to :coin

  validates :coin_id, presence: true
  validates :price, presence: true
end
