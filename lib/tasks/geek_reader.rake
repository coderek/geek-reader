namespace :geek_reader do
  desc "Refresh all feeds"
  task refresh_all_feeds: :environment do
    puts "starting to refresh all feeds at #{Time.now}"
    Feed.all.each do |f|
      f.fetch_feed
    end
  end

  desc "Obsolete entries that are older than 2 months"
  task obsolete_entries: :environment do
    Entry.where(["published < ? and is_read = 0", Time.now - 2.months]).update_all({is_read: 1})
  end
end
