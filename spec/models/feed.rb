require "spec_helper"


describe Feed do
  include FeedsHelper

  before do
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