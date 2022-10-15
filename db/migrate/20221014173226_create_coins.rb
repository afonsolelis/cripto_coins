# frozen_string_literal: true

class CreateCoins < ActiveRecord::Migration[7.0]
  def change
    create_table :coins do |t|
      t.string :name
      t.string :last_price

      t.timestamps
    end
  end
end
