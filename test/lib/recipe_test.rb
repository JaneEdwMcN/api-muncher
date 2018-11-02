require 'test_helper'

describe Recipe do

  it "cannot be initialized with less than 2 parameters" do
    expect {
      Recipe.new
    }.must_raise ArgumentError

    expect {
      Recipe.new "Name"
    }.must_raise ArgumentError
  end

  it "must initialize name & id properly" do
    recipe = Recipe.new("Name", "ID")
    expect(recipe.name).must_equal "Name"
    expect(recipe.id).must_equal "ID"
  end

  it "can be created with a name, id, url, img, ingredients, dietary_information, and author" do

    dietary_information = ["vegan", "fat-free"]
    ingredients = ["chocolate", "whipped cream", "sugar", "butter"]

    myRecipe = Recipe.new('chocolate cake', '12345', url: "www.cake.com", img: "www.cake.jpg", ingredients: ingredients, dietary_information: dietary_information, author: "Martha Stewart")
    expect(myRecipe.name).must_equal 'chocolate cake'
    expect(myRecipe.id).must_equal '12345'
    expect(myRecipe.url).must_equal "www.cake.com"
    expect(myRecipe.img).must_equal "www.cake.jpg"
    expect(myRecipe.ingredients).must_equal ingredients
    expect(myRecipe.dietary_information).must_equal dietary_information
  end

end
