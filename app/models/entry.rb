require "open-uri"
class Entry < ActiveRecord::Base
  include FeedsHelper

  belongs_to :feed
  validates_uniqueness_of :uuid, :scope=>:feed_id

  before_save :process_article

  def social_share_button_tags
    ApplicationController.helpers.social_share_button_tag(title, :url => url)
  end

  def attributes
    super.merge({:social_share_button_tags=>nil})
  end

  def process_article
    feed_domain = get_domain(feed.url)
    extended_content = content.to_s + summary.to_s
    if published.blank?
      write_attribute(:published , Time.now)
    end

    if feed.secondary_fetch == 1
      begin
        source = open(url).read
        fetched_content = Readability::Document.new(source, {
                tags: Loofah::HTML5::WhiteList::ALLOWED_ELEMENTS,
                attributes: Loofah::HTML5::WhiteList::ACCEPTABLE_ATTRIBUTES
            }).content
        compound_content = fetched_content + extended_content
        write_attribute :content,  (parse_article compound_content, get_domain(url))
      rescue Exception => e
        logger.info "entry refetch error for #{title}:  #{e}"
        write_attribute :content, (parse_article extended_content, feed_domain)
      end
    else
      write_attribute  :content, (parse_article extended_content, feed_domain)
    end
  end

end