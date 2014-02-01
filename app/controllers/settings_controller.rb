class SettingsController < ApplicationController
  before_filter :authenticate
  def index
    categories
    render "categories"
  end

  def categories
    @categories = current_user.categories
    @category = Category.new
  end

  def preference
    
  end
end