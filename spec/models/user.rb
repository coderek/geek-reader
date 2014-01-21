require "spec_helper"

describe User do
  before do
    @user = create(:user_with_feed)
    @feed = @user.feeds.first
  end

  it "should create a user" do
    @user.should_not be_nil
  end

  it "can add feed to user object with feed_url" do
    @feed.should_not be_nil
  end

  it "should fetch feeds after create" do
    @feed.url.should_not be_nil
  end

  it "should have some entries" do
    @feed.entries.count > 0
  end
end