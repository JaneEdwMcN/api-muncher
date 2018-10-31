require 'httparty'
class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/"
  ID = ENV["APP_ID"]
  KEY = ENV["APP_KEY"]

  def self.list_recipes(ingredients)
    url = BASE_URL + "search?" + "q=#{ingredients}" + "&app_id=#{ID}&app_key=#{KEY}" + "&to=100"
    #add encode URL
    data = HTTParty.get(url)
    recipe_list = []
    if data["hits"].length > 0
      data["hits"].each do |recipe_data|
        recipe_list << create_recipe(recipe_data["recipe"])
      end
      return recipe_list
    else
      return nil
    end

  end

  def self.find_recipe(id)
    url = BASE_URL + "search?" + "r=http%3A%2F%2Fwww.edamam.com%2Fontologies%2Fedamam.owl%23recipe_#{id}" + "&app_id=#{ID}&app_key=#{KEY}"
    data = HTTParty.get(url)
    if data.length > 0
      recipe = create_recipe(data[0])
      return recipe
    else
      return nil
    end
  end

  private

  def self.create_recipe(api_params)
    underscore = api_params["uri"].index("_") + 1
    uri = api_params["uri"][(underscore)..-1]
    return Recipe.new(
      api_params["label"],
      uri,
      {
        url: api_params["url"],
        img: api_params["image"],
        ingredients: api_params["ingredientLines"],
        dietary_information: api_params["healthLabels"]
      }
    )
  end
end
