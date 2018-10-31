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
  # "http://www.edamam.com/ontologies/edamam.owl#recipe_ded90f29509f7f9fe307dc76f1ba3b44"
  # http%3A%2F%2Fwww.edamam.com%2Fontologies%2Fedamam.owl%23recipe_fbdf4f457c6837f1f3dff02c2db242c0
  def self.find_recipe(id)
    # uri.gsub!("/", "%2F")
    # uri.gsub!(":", "%3A")
    # uri.gsub!("#", "%23")
    # underscore = id.index("_") + 1
    # uri_code = id[(underscore)..-1]
    url = BASE_URL + "search?" + "r=http%3A%2F%2Fwww.edamam.com%2Fontologies%2Fedamam.owl%23recipe_#{id}" + "&app_id=#{ID}&app_key=#{KEY}"
    data = HTTParty.get(url)
    if data
      recipe = create_recipe_too(data)
    end
    return recipe
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

  def self.create_recipe_too(api_params)
    return Recipe.new(
      api_params[0]["label"],
      api_params[0]["uri"],
      {
        url: api_params[0]["url"],
        img: api_params[0]["image"], #
        ingredients: api_params[0]["ingredientLines"], #
        dietary_information: api_params[0]["healthLabels"] #
      }
    )
  end
end
