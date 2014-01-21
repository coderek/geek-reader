require "spec_helper"


describe Feed do

  before do
    User.create({username: "zen", password: "zen"})
    url = "http://codingnow.com/atom.xml"
    f = Feedzirra::Feed.fetch_and_parse url
    @feed = User.first.add_feed(f)
  end

  it "fetch and store feed" do
    @feed.should_not be_nil
  end

  it "has some entires " do
    @feed.should have_at_least(1).entry
  end

  it "update from the source very well" do

  end
end