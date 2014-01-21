class EntriesController < ApplicationController
  respond_to :json
  before_filter :authenticate

  def index
    respond_with(current_user.feeds.find(params[:feed_id]).entries.reverse)
  end

  def refresh
    feed = current_user.feeds.find params[:feed_id]
    if feed
      feed.fetch_feed
      respond_with feed.entries.reverse
    end
  end
end