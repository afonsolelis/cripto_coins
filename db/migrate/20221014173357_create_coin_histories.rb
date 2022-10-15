# frozen_string_literal: true

class CreateCoinHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :coin_histories do |t|
      t.string :price
      t.references :coin, null: false, foreign_key: true

      t.timestamps
    end
  end
end
