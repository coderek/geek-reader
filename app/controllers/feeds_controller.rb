class FeedsController < ApplicationController
  respond_to :json
  before_filter :authenticate

  def create
    f = Feedzirra::Feed.fetch_and_parse feed_params[:url]

    if f and not f.is_a? Integer
      feed = current_user.add_feed(f)
      respond_with(feed)
    else
      render status: 404, json: {}
    end
  end

  def index
    respond_with(current_user.feeds)
  end

  def destroy
    current_user.feeds.destroy(feed_params[:id])
    render status: 200, json:{}
  end

  private
  def feed_params
    params.permit(:url, :id)
  end

end