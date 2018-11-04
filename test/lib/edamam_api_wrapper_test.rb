require 'test_helper'

describe EdamamApiWrapper do

  describe "list_recipes" do
    it "can list recipes" do
      VCR.use_cassette("recipes") do
        recipes = EdamamApiWrapper.list_recipes("chocolate")

        expect(recipes.length).must_be :>, 0
        expect(recipes.length).must_be :<=, 100
        recipes.each do |recipe|
          expect(recipe).must_respond_to :name
          expect(recipe).must_respond_to :id
        end
      end
    end

    it "returns nil if not given a real word" do
      VCR.use_cassette("recipes") do
        recipes = EdamamApiWrapper.list_recipes("akdshfajgsdfj")
        expect(recipes).must_be_nil
      end
    end

    it "returns nil if not given a word" do
      VCR.use_cassette("recipes") do
        recipes = EdamamApiWrapper.list_recipes(nil)
        expect(recipes).must_be_nil
      end

      VCR.use_cassette("recipes") do
        recipes = EdamamApiWrapper.list_recipes("")
        expect(recipes).must_be_nil
      end
    end

  end

  describe "find_recipe" do
    it "can find a recipe with valid uri" do
      VCR.use_cassette("recipe") do
        recipe = EdamamApiWrapper.find_recipe("00e89ef04a409f17dd01db6b92d83100")

        expect(recipe.id).must_equal "00e89ef04a409f17dd01db6b92d83100"
        expect(recipe).must_be_kind_of Recipe
        expect(recipe).must_respond_to :name
        expect(recipe).must_respond_to :id
      end
    end

    it "won't find a recipe with an invalid uri" do
      VCR.use_cassette("recipe") do
        recipe = EdamamApiWrapper.find_recipe("hello")
        expect(recipe).must_be_nil
      end
    end

    it "won't find a recipe without a uri" do
      VCR.use_cassette("recipe") do
        recipe = EdamamApiWrapper.find_recipe("")
        expect(recipe).must_be_nil
      end

      VCR.use_cassette("recipe") do
        recipe = EdamamApiWrapper.find_recipe(nil)
        expect(recipe).must_be_nil
      end
    end
  end

  describe "create_recipe" do
    it "can create a recipe with valid params" do
      params = {
        "label" => "choclate cake", "uri" => "_1234567", "url" => "www.cake.com", "image" => "www.cake.jpg", "ingredientLines" => ["butter", "choclate", "sugar"], "healthLabels" => ["vegan"], "source" => "Martha Stewart"
      }
      myRecipe = EdamamApiWrapper.create_recipe(params)
      expect(myRecipe).must_be_kind_of Recipe
      expect(myRecipe.name).must_equal params["label"]
      expect(myRecipe.id).must_equal "1234567"
      expect(myRecipe.url).must_equal params["url"]
      expect(myRecipe.img).must_equal params["image"]
      expect(myRecipe.ingredients).must_equal params["ingredientLines"]
      expect(myRecipe.dietary_information).must_equal params["healthLabels"]
    end

    it "wont create a recipe with invalid params" do
      params = {}
      expect {
        EdamamApiWrapper.create_recipe(params)
      }.must_raise ArgumentError
    end
  end

end
