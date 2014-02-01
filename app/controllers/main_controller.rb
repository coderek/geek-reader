class MainController < ApplicationController
  before_filter :authenticate, except: [:index]

  def index
    render :layout => "application"
  end

  def reader
  end

  def settings
    render :layout=>"settings"
  end
end