class EntriesController < ApplicationController
  respond_to :json
  before_filter :authenticate

  def index
    respond_with(current_user.feeds.find(params[:feed_id]).entries)
  end
end