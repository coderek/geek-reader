class User < ActiveRecord::Base
  has_many :feeds, :dependent => :destroy
  has_many :categories, :dependent =>  :destroy
  has_many :authentications, :dependent => :destroy

  has_secure_password
  validates_presence_of :email
  validates_uniqueness_of :email
  after_create :create_category


  def create_category
    categories.create({:name=>"Default"})
  end

  def as_json(options = {})
    super(options.merge({ except: [:auth_token, :password_hash, :password_salt] }))
  end

  def update_feeds
    feeds.each(&:fetch_feed)
  end

  def password_required?
    (authentications.empty? || !password.blank?)
  end
end
