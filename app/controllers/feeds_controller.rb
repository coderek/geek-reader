class FeedsController < ApplicationController
  respond_to :json
  before_filter :authenticate

  def create

    if feed = current_user.feeds.create({:feed_url => feed_params[:url]})
      respond_with(feed)
    else
      respond_with({}, status: 404)
    end
  end

  def update
    pparams = params.permit(:category, :id)
    respond_with(Entry.update(pparams[:id], pparams))
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
    params.permit(:url, :id, :category)
  end

end