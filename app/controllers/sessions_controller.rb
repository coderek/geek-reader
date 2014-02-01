class SessionsController < ApplicationController
  respond_to :json

  def new
  end

  def index
    if current_user
      respond_with(current_user)
    else
      render status: 401, json: {}
    end
  end

  def create
    user = User.find_by_email(session_params[:email])
    if user and user.authenticate(session_params[:password])
      session[:user] = user.id
      redirect_to :reader
    else
      redirect_to :root, :notice => "username or password is wrong"
    end
  end

  def destroy
    session[:user] =nil
    redirect_to :root
  end

  private
  def session_params
    params.permit(:email, :password)
  end
end