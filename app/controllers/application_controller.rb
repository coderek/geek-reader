class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def current_user
    @current_user ||= User.find(session[:user]) if session[:user]
  end

  def authenticate
    unless current_user
      redirect_to :root
    end
  end

  helper_method :current_user
end
