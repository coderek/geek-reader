namespace :geek_reader do
  desc "Refresh all feeds"
  task refresh_all_feeds: :environment do
    puts "starting to refresh all feeds at #{Time.now}"
    Feed.all.each do |f|
      f.fetch_feed
    end
  end
end
