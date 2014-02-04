class CategoriesController < ApplicationController
  before_filter :authenticate
  respond_to :json

  def index
    cats = []
    #Category.includes(:feeds).find_all_by_user_id(current_user.id).each do |c|
    #  cats << {:category=>c, :feeds => c.feeds}
    #end
    render json: current_user.categories
  end

  def feeds
    render json:  current_user.categories.find(params[:id]).feeds
  end

  def create
    cat = current_user.categories.create(params.require(:category).permit(:name))
    if cat.persisted?
      respond_with cat
    else
      render json:cat.errors, status: 401
    end
  end

  def update
    pp = params.permit(:id, :name)
    cat = current_user.categories.find(pp[:id])
    cat.update({name: params[:name]})
    respond_with(cat)
  end

  def destroy
    current_user.categories.find(params.permit(:id)[:id]).destroy()
    redirect_to :back
  end
end