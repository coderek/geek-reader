class FeedsController < ApplicationController
  respond_to :json
  before_filter :authenticate

  def create
    if feed = current_user.feeds.create(feed_params)
      respond_with(feed)
    else
      respond_with({}, status: 404)
    end
  end

  def update
    feed = current_user.feeds.find(feed_params[:id])
    if feed and feed.update(feed_params)
      render json: feed
    else
      render json: "error update", status: 500
    end
  end

  def index
    respond_with(current_user.feeds)
  end

  def destroy
    render json: current_user.feeds.destroy(feed_params[:id])
  end

  def mark_read
    feed = current_user.feeds.find(feed_params[:id])
    render :status=> 404 unless feed
    if params[:age] == nil
      entries = feed.entries.where("is_read = 0")
      ids = entries.map(&:id)
      entries.update_all({is_read: 1})
      render :json => ids
    elsif params[:age] == "1day"
      t = Time.now - 1.day
      entries = feed.entries.where(["published < ? OR created_at < ? AND is_read = 0", t, t])
      ids = entries.map(&:id)
      entries.update_all({is_read: 1})
      render :json => ids
    elsif params[:age] == "1week"
      t = Time.now - 1.week
      entries = feed.entries.where(["published < ? OR created_at < ? AND is_read = 0", t, t])
      ids = entries.map(&:id)
      entries.update_all({is_read: 1})
      render :json => ids
    end
  end

  private
  def feed_params
    params.permit(:feed_url, :id, :category_id, :title, :style)
  end
end