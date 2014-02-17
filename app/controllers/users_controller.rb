class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate, except: [:new, :create]

  def index
    #@users = User.all
  end

  def show
  end

  def feeds
    super.order("last_modified DESC")
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    if session[:omniauth]
      random_pass = SecureRandom.hex[0...8]
      pm = user_params.merge({:password=>random_pass, :password_confirmation=>random_pass})
      user = User.new(pm)
      auth_hash = session[:omniauth]
      if user.save
        session[:user] = user.id
        user.authentications.create({:provider=> auth_hash[:provider] , :uid=> auth_hash[:uid]})

        session[:omniauth] = nil

        flash[:notice] = "You have successfully created your account and logged in."
        redirect_to :reader
      else
        redirect_to :register, :notice => "Authentication error. #{user.errors.full_messages}"
      end
    else
      @user = User.create(user_params)
      if @user.persisted?
        redirect_to :login, :notice=> "Please login now"
      else
        redirect_to :back, :notice=>"Invalid Information"
      end
    end
  end

  def update
    respond_with(@user.save(user_params))
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
