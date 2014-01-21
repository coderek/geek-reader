class SessionsController < ApplicationController
  respond_to :json

  def index
    if current_user
      respond_with(current_user)
    else
      render status: 401, json: {}
    end
  end

  def create
    user = User.authenticate(session_params[:username], session_params[:password])
    if user
      if session_params[:remember]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      end
      respond_with(user)
    else
      render status: 401, json: {}
    end
  end

  def destroy
    id = current_user.id
    cookies.delete(:auth_token)
    respond_with(User.find(id))
  end

  private
  def session_params
    params.permit(:username, :password, :remember)
  end
end