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
    @user = User.create(user_params)
    if @user.persisted?
      redirect_to :root
    else
      redirect_to :back, :notice=>"Invalid Information"
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
