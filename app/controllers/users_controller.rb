class UsersController < ApplicationController
  respond_to :json
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    #@users = User.all
  end

  def show
  end

  def new
    #@user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save()
      respond_with(@user)
    else
      render status: 500, json: @user.errors
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
    params.permit(:username, :password, :password_confirmation)
  end
end
