class SessionsController < ApplicationController
  respond_to :json
  def index
    respond_with(current_user)
  end
end