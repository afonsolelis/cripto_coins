# frozen_string_literal: true

module Math
  class AngularCoeficient
    attr_accessor :prices

    def initialize(prices)
      self.prices = prices
    end

    def call
      angular_coeficient
    end

    private

    def angular_coeficient
      n = prices.size
      x = (1..n).to_a.sum
      y = prices.sum
      x_sqrt = (1..n).to_a.map { |i| i**2 }.sum
      xy = (1..n).to_a.zip(prices).map { |x, y| x * y }.sum
      (n * xy - x * y) / (n * x_sqrt - x**2)
    end
  end
end
