source 'https://rubygems.org'
ruby ENV['CUSTOM_RUBY_VERSION'] || '2.1.0'
gem 'rails', '4.0.0'

group :production do
  gem 'pg'
end

group :development do
  # gem 'sqlite3'
  gem 'pg'
end
group :test, :development do
  gem 'rspec-rails'
  gem 'factory_girl_rails', '~> 4.0'
end

gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'

gem 'jquery-rails'
gem 'bourbon'
gem 'backbone-on-rails'

# encrypt password
gem 'bcrypt-ruby', '~> 3.0.1', require: 'bcrypt'

# feed related gem
gem 'feedjira'
gem 'loofah'

gem 'unicorn-rails'
gem 'ruby-readability', :require => 'readability'

# cron task
gem 'whenever', :require => false

gem 'rails_12factor', group: :production

# for sharing 
gem 'social-share-button'

gem 'omniauth'
gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'

