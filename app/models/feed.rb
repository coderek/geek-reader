class Feed < ActiveRecord::Base
  belongs_to :user
  has_many :entries, :dependent => :destroy
  validates_uniqueness_of :feed_url

  def add_entries c
    c.entries.each do |e|
      hash = {}
      hash[:title]      = e.title
      hash[:url]        = e.url
      hash[:author]     = e.author
      hash[:summary]    = e.summary
      hash[:published]  = e.published
      hash[:categories] = e.categories.join(",") if e.respond_to? :categories
      hash[:uuid]       = e.id
      if e.respond_to? :content
        hash[:content]    = e.content
      else
        hash[:content]    = ""
      end
      entries.create(hash)
    end
  end
end