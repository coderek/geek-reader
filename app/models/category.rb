class Category < ActiveRecord::Base
  has_many :feeds
  belongs_to :user
  validates_uniqueness_of :name, scope: :user_id
  validates_presence_of :name
end
