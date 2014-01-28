class Entry < ActiveRecord::Base
  belongs_to :Feed
  validates_uniqueness_of :uuid, :scope=>:feed_id
end