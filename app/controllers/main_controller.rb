class MainController < ApplicationController
  before_filter :authenticate

  def index
  end

  def settings
    render :layout=>"settings"
  end
end