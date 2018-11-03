class RecipesController < ApplicationController
  before_action :ingredients, except: [:main, :show]

  def index
    health_labels = params[:health_labels]
    @recipes = EdamamApiWrapper.list_recipes(@ingredients, health_labels)
    if @recipes.nil?
      flash[:status] = :warning
      flash[:result_text] = "No recipes found for #{@ingredients}. Please try again with different words."
      redirect_to root_path
    else
      @recipes_paginated = Kaminari.paginate_array(@recipes).page(params[:page]).per(8)
    end
  end

  def show
    @recipe = EdamamApiWrapper.find_recipe(params[:id])
    if @recipe.nil?
      flash[:status] = :danger
      flash[:result_text] = "Could not find recipe. Please search again."
      redirect_to root_path
    end
  end

  def main
    @on_main = true
  end

  private
  def ingredients
    @ingredients = params[:ingredients]

    if @ingredients.nil?
      flash[:status] = :danger
      flash[:result_text] = "Could not find recipes. Invalid seach params."
      redirect_to root_path
    end
  end
end
