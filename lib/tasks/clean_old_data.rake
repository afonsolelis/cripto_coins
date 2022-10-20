namespace :coins do
  desc "Deletes old data"
  task clean_old_data: :environment do
    range = (15.days.ago..3.days.ago)
    CoinHistory.where(created_at: range).delete_all
    puts 'old data purged'
  end
end
