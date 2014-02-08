require "open-uri"
class Entry < ActiveRecord::Base
  include FeedsHelper

  belongs_to :feed
  validates_uniqueness_of :uuid, :scope=>:feed_id

  before_save :process_article


  def process_article
    domain = get_domain(feed.url)
    content = parse_article content, domain
    summary = parse_article summary, domain

    logger.info "=========== secondary fetch: #{feed.secondary_fetch} ==================="
    # check if this feed need to be fetched again
    if feed.secondary_fetch == 1 and secondary_fetched != 1
      begin
        source = open(url).read
        fetched_content = parse_article(
            Readability::Document.new(source, {
                tags: Loofah::HTML5::WhiteList::ALLOWED_ELEMENTS,
                attributes: Loofah::HTML5::WhiteList::ACCEPTABLE_ATTRIBUTES
            }).content, domain)
        if feed.fetch_type == "append"
          self.content = fetched_content + content + summary
        else
          self.content = fetched_content
        end
        self.summary = "" # use only content
        self.secondary_fetched = 1
      rescue Exception => e
        logger.info "entry refetch error for #{title}:  #{e}"
      end
    end
  end
end