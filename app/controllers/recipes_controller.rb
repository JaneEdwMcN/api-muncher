class RecipesController < ApplicationController
  before_action :ingredients

  def index
    @recipes = EdamamApiWrapper.list_recipes(@ingredients)
  end

  def new
    @ingredients = params[:ingredients]
  end

  def main
  end

  private
  def ingredients
    @ingredients = params[:ingredients]

    # if @ingredients.nil?
    #   flash.now[:danger] = "Message"
    #   render :notfound, status: :not_found
    # end
  end
end
