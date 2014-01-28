class User < ActiveRecord::Base
  has_many :feeds, :dependent => :destroy
  has_many :categories, :dependent =>  :destroy
  has_secure_password
  validates_presence_of :email
  validates_uniqueness_of :email

  def as_json(options = {})
    super(options.merge({ except: [:auth_token, :password_hash, :password_salt] }))
  end

  def update_feeds
    feeds.each(&:fetch_feed)
  end
end
