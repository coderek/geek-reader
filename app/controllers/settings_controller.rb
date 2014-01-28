class SettingsController < ApplicationController
  before_filter :authenticate
  def index
    render "preference"
  end

  def categories
    @categories = current_user.categories
    @category = Category.new
  end

  def preference
    
  end
end