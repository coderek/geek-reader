class AuthenticationsController < ApplicationController
  layout "auth"

  def index

  end

  def  create
    authentication = Authentication.find_by_provider_and_uid(auth_hash['provider'], auth_hash['uid'])

    if authentication
      # sign in user
      session[:user] = authentication.user_id
      flash[:notice] = "You have signed in successfully."
      redirect_to :reader
    elsif current_user
      # user already signed in, so create the oauth authentication information
      current_user.authentications.find_or_create_by_provider_and_uid(auth_hash['provider'], auth_hash['uid'])
      flash[:notice] = "You have successfully added #{auth_hash[:provider]} authentication."
      redirect_to :reader
    else
      # user not signed in and user no authentication found, then create a user with that authentication
      email = auth_hash[:info][:email]
      if email.blank?
        session[:omniauth] = auth_hash.except('extra')
        redirect_to :register
      else
        # generate a random password
        random_pass = SecureRandom.hex[0...8]
        user = User.new({:email=>email, :password=>random_pass, :password_confirmation=>random_pass})
        if user.save
          session[:user] = user.id
          user.authentications.create({:provider=> auth_hash[:provider] , :uid=> auth_hash[:uid]})
          flash[:notice] = "You have successfully created your account and logged in."
          redirect_to :reader
        else
          redirect_to :login, :notice => "Authentication error. #{user.errors.full_messages}. If you have already register using a email address before, please login first then come to this page to bind a OAuth account."
        end
      end
    end
  end

  def destroy

  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

end
