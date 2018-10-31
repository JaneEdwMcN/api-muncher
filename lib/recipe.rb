class Recipe
  attr_reader :name, :id, :url, :img, :ingredients, :dietary_information

  def initialize(name, id, url: "", img: "", ingredients: [], dietary_information: [] )
    raise ArgumentError if name == nil || name == "" || id == nil || id == ""

    @name = name
    @id = id
    @url = url
    @img = img
    @ingredients = ingredients
    @dietary_information = dietary_information
  end

end
