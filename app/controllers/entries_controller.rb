class EntriesController < ApplicationController
  respond_to :json
  before_filter :authenticate

  LIMIT = 20

  def index
    page = params[:page] || 0
    entries = current_user.feeds.find(params[:feed_id]).entries.limit(LIMIT).offset(LIMIT*page.to_i)
    respond_paged_entries entries
  end

  def category
    page = params[:page] || 0
    fids =current_user.feeds.where(:category_id => params[:category_id]).map(&:id)
    entries = Entry
    .except(:content, :summary)
    .limit(LIMIT)
    .offset(LIMIT*page.to_i)
    .order("published Desc, created_at Desc")
    .find_all_by_feed_id_and_is_read(fids, 0)

    respond_paged_entries entries.shuffle
  end

  def unread
    page = params[:page] || 0
    fids =current_user.feeds.map(&:id)
    entries = Entry
      .except(:content, :summary)
      .limit(LIMIT)
      .offset(LIMIT*page.to_i)
      .order("published Desc, created_at Desc")
      .find_all_by_feed_id_and_is_read(fids, 0)

    respond_paged_entries entries.shuffle
  end

  def starred
    page = params[:page] || 0
    fids =current_user.feeds.map(&:id)
    entries = Entry
      .except(:content, :summary)
      .limit(LIMIT)
      .offset(LIMIT*page.to_i)
      .order("published Desc, created_at Desc")
      .find_all_by_feed_id_and_is_starred(fids, 1)
    respond_paged_entries entries
  end

  def refresh
    feed = current_user.feeds.find params[:feed_id]
    if feed
      entries = feed.fetch_feed
      if entries.is_a? Array
        respond_with entries
      else
        render :json => []
      end
    else
      render :json => []
    end
  end

  def update
    pa = params.permit(:is_read, :is_starred, :id)
    respond_with(Entry.update(pa[:id], pa))
  end

  private
  def respond_paged_entries entries
    respond_with(entries)
  end
end