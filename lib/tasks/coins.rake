namespace :coins do
  desc "U;date Coins"
  task update_coins: :environment do
    @coin_names = HTTParty.get('https://www.mercadobitcoin.net/api/coins')
    puts 'Updating coins...'
    @coin_names.each do |coin_name|
      db_coin = Coin.where(name: coin_name).first
      last_price_consulted = HTTParty.get("https://www.mercadobitcoin.net/api/#{coin_name}/ticker/")['ticker']['last']
      Coin.create!(name: coin_name, last_price: last_price_consulted) if db_coin.nil?
      db_coin = Coin.where(name: coin_name).first
      sleep 20
      CoinHistory.create!(coin_id: db_coin.id, price: last_price_consulted)
      db_coin.update(last_price: last_price_consulted)
    end
    puts 'Coins updated!'
  end
end
