class SettingsController < ApplicationController
  before_filter :authenticate
  def index
    render "preference"
  end

  def categories
    @categories = current_user.categories
  end

  def preference
    
  end
end