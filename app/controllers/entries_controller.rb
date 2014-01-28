class EntriesController < ApplicationController
  respond_to :json
  before_filter :authenticate

  def index
    limit = 20
    page = params[:page] || 0
    entries = current_user.feeds.find(params[:feed_id]).entries.limit(limit).offset(limit*page.to_i)
    if entries.count > 0
      respond_with(entries)
    else
      respond_with(nil, status: 404)
    end
  end

  def refresh
    feed = current_user.feeds.find params[:feed_id]
    if feed
      feed.fetch_feed
      respond_with feed.entries
    end
  end

  def update
    pa = params.permit(:is_read, :is_starred, :id)
    respond_with(Entry.update(pa[:id], pa))
  end
end