class Recipe
  attr_reader :name, :id, :url, :img, :ingredientLines, :healthLabels

  def initialize(name, id, options = {} )
    raise ArgumentError if name == nil || name == "" || id == nil || id == ""

    @name = name
    @id = id

    @url = options[:url]
    @img = options[:img]
    @ingredients = options[:ingredients]
    @dietary_information = options[:dietary_information]
  end

end
