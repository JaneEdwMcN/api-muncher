require 'httparty'
class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/"
  ID = ENV["APP_ID"]
  KEY = ENV["APP_KEY"]

  def self.list_recipes(ingredients, health_labels)
    health = ""
    if health_labels
      health_labels.each do |label|
        health +=  "&health=#{label}"
      end
    end
    url = BASE_URL + "search?" + "q=#{ingredients}" + "&app_id=#{ID}&app_key=#{KEY}" + "&to=80&excluded=BANANAS&excluded=BANANA&excluded=pl%C3%A1tano&excluded=onions&excluded=onion&excluded=mushrooms&excluded=avocado" + health
    #add encode URL??
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
    if api_params["uri"]
      uri = api_params["uri"]
      uri =  api_params["uri"].partition("_").last if api_params["uri"].include? ("_")
    end
    return Recipe.new(
      api_params["label"],
      uri,
      {
        url: api_params["url"],
        img: api_params["image"],
        ingredients: api_params["ingredientLines"],
        dietary_information: api_params["healthLabels"],
        author: api_params["source"]
      }
    )
  end
end
