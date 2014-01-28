class CategoriesController < ApplicationController
  before_filter :authenticate
  respond_to :json

  def index
    cats = []
    Category.includes(:feeds).find_all_by_user_id(current_user.id).each do |c|
      cats << {:category=>c, :feeds => c.feeds}
    end
    render json: cats
  end
end