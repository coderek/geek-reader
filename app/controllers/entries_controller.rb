class EntriesController < ApplicationController
  respond_to :json
  before_filter :authenticate

  def index
    limit = 20
    entries = current_user.feeds.find(params[:feed_id]).entries.limit(limit).reverse
    respond_with(entries)
  end

  def refresh
    feed = current_user.feeds.find params[:feed_id]
    if feed
      feed.fetch_feed
      respond_with feed.entries.reverse
    end
  end

  def update
    pa = params.permit(:is_read, :is_starred, :id)
    logger.debug("--------update entry---------")
    logger.debug(pa)
    respond_with(Entry.update(pa[:id], pa))
  end
end