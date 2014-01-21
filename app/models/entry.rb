class Entry < ActiveRecord::Base
  belongs_to :Feed
  validates_uniqueness_of :uuid
end