class Category < ActiveRecord::Base
  has_many :feeds
  belongs_to :user
  validates_uniqueness_of :name, scope: :user_id
  validates_presence_of :name

  before_destroy :move_to_default

  def move_to_default
    return false if name =~ /default/i

    default = Category.where("name like 'default'").first
    return if default == nil
    feeds.each do |feed|
      feed.update(:category_id => default.id)
    end
  end

  def attributes
    super.merge({:feeds=>feeds})
  end

end
