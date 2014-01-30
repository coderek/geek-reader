# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

path = File.expand_path(File.dirname(__FILE__)+"/feeds.yml")
data = YAML::load(File.read(path))

data['users'].each do |u|
  User.create({:email=>u['email'], :password=> u['password'], :password_confirmation=>u['password']})
end

data['categories'].each do |cat|
  Category.create({:name=> cat, :user_id=>User.first.id})
end

data['feeds'].each do |f|
  url, cat_name = f.split /,\W/
  cat = Category.find {|c| c.name =~ Regexp.new(cat_name, true)}
  if cat
    cat.feeds.create({:feed_url=> url, :user_id=>User.first.id})
    puts "created feed: #{f}"
  end
end