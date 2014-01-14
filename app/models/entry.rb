class Entry < ActiveRecord::Base
  belongs_to :Feed
  validates_uniqueness_of :url
end