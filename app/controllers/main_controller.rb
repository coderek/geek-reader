class MainController < ApplicationController
  before_filter :authenticate, except: [:index]

  def index
    @user = User.new
    render :layout => "application"
  end

  def reader
  end

  def settings
    render :layout=>"settings"
  end
end