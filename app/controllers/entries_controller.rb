class EntriesController < ApplicationController
  respond_to :json
  before_filter :authenticate

  LIMIT = 20

  def index
    page = params[:page] || 0
    entries = current_user.feeds.find(params[:feed_id]).entries.limit(LIMIT).offset(LIMIT*page.to_i)
    logger.debug current_user.inspect
    logger.debug entries
    respond_paged_entries entries
  end

  def unread
    page = params[:page] || 0
    fids =current_user.feeds.map(&:id)
    entries = Entry.except(:content, :summary).limit(LIMIT).offset(LIMIT*page.to_i).find_all_by_feed_id_and_is_read(fids, nil)
    respond_paged_entries entries
  end

  def starred
    page = params[:page] || 0
    fids =current_user.feeds.map(&:id)
    entries = Entry.except(:content, :summary).limit(LIMIT).offset(LIMIT*page.to_i).find_all_by_feed_id_and_is_starred(fids, 1)
    respond_paged_entries entries
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

  private
  def respond_paged_entries entries
    if entries.count > 0
      respond_with(entries)
    else
      respond_with(nil, status: 404)
    end
  end
end