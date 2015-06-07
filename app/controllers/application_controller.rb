class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def current_user
    @current_user ||= User.find(session[:user]) if session[:user]
  end

  def authenticate

    case request.media_type
    when "application/json"
      if user = authenticate_with_http_basic {|u, p|  User.find_by_email(u) }
        session[:user] = user.id
      else
        request_http_basic_authentication
      end
    else
      unless current_user
        redirect_to :root
      end
    end
  end

  helper_method :current_user
end
