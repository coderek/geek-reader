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
    unless user
      redirect_to :login, :notice=>"user not found"
    end
    if user.authenticate(session_params[:password])
      session[:user] = user.id
      redirect_to :root
    else
      redirect_to :login, :notice => "username or password is wrong"
    end
  end

  def destroy
    session[:user] =nil
    redirect_to :login
  end

  private
  def session_params
    params.permit(:email, :password)
  end
end