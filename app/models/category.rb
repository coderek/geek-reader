class Category < ActiveRecord::Base
  has_many :feeds
  belongs_to :user
end
