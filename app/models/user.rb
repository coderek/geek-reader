class User < ActiveRecord::Base
  attr_accessor :password
  before_save :encrypt_password
  before_create { generate_token(:auth_token) }

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

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def as_json(options = {})
    super(options.merge({ except: [:auth_token, :password_hash, :password_salt] }))
  end

  def self.authenticate username, password
    user = find_by_username username
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      return user
    else
      return nil
    end
  end

  def update_feeds
    feeds.each(&:fetch_feed)
  end
end
