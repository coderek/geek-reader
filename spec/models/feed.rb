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

  it "store entry content after wash the content" do
    url = "http://www.yinwang.org/atom.xml"
    f = Feedzirra::Feed.fetch_and_parse url
    @feed = User.first.add_feed(f)
    article = @feed.entries.find_by_uuid("http://www.yinwang.org/blog-cn/2013/04/21/ydiff-结构化的程序比较")
    article.should_not be_nil
    article.content.should_not =~ /link href/
  end
end