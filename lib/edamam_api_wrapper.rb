require 'httparty'
class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/"
  ID = ENV["APP_ID"]
  KEY = ENV["APP_KEY"]

  def self.list_recipes(ingredients)
    url = BASE_URL + "search?" + "q=#{ingredients}" + "&app_id=#{ID}&app_key=#{KEY}"
    data = HTTParty.get(url)
    recipe_list = []
    if data["hits"]
      data["hits"].each do |recipe_data|
        recipe_list << create_recipe(recipe_data["recipe"])
      end
    end
    return recipe_list
  end

  private

  def self.create_recipe(api_params)
    return Recipe.new(
      api_params["label"],
      api_params["uri"],
      {
        url: api_params["url"],
        img: api_params["image"], #
        ingredients: api_params["ingredientLines"], #
        dietary_information: api_params["healthLabels"] #
      }
    )
  end
end
