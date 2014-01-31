require "spec_helper"


describe Feed do
  include FeedsHelper

  before do
  end

  it "should be able to refresh the feed correctly" do
    feed = Feedzirra::Feed.parse File.read(File.expand_path(File.dirname(__FILE__)+"/sample_rss2.xml"))
    f = Feed.create(:feed_url=>"http://codingc.om/feed")
    f.fetch_feed feed
    f.title.should == feed.title
    f.entries.count.should == 3
    new_feed = Feedzirra::Feed.parse File.read(File.expand_path(File.dirname(__FILE__)+"/sample_rss1.xml"))
    updated = f.fetch_feed new_feed
    updated.count.should == 2
    f.entries.count.should == 5
  end

  it "scrub correct" do
    dingding = Feed.find(8)
    entry = dingding.entries.first
    scrubber = FeedsHelper::WhiteWatch.new(dingding.url)
    doc = Loofah.fragment(entry.content)
    doc.scrub!(scrubber)
    s = doc.to_s
    p s[/<img.*>/]
    s.should_not be_nil
  end
end