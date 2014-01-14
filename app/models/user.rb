class User < ActiveRecord::Base
  attr_accessor :password
  before_save :encrypt_password

  validates_presence_of :password, :on=>:create
  validates_presence_of :username
  validates_uniqueness_of :username
  validates_confirmation_of :password

  has_many :feeds, :dependent => :destroy

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def self.authenticate username, password
    user = find_by_username username
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      return user
    else
      return nil
    end
  end

  def add_feed c
    feed = feeds.new
    feed.url            = c.url
    feed.title          = c.title
    feed.description    = c.description
    feed.etag           = c.etag
    feed.feed_url       = c.feed_url
    feed.last_modified  = c.last_modified
    feed.save
    feed.add_entries(c)
    feed
  end
end
