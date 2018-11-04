require "test_helper"
describe RecipesController do

  describe "index" do
    it "can get the index path" do
      ingredients = {ingredients: "chocolate"}
      VCR.use_cassette('recipes') do
        get recipes_path, params: ingredients

        must_respond_with :ok
      end
    end

    it "will redirect with invalid search terms" do
      ingredients = {ingredients: "aksdfjhasdgfkj"}
      VCR.use_cassette('recipes') do
        get recipes_path, params: ingredients

        expect(flash[:status]).must_equal :warning
        expect(flash[:result_text]).must_equal "No recipes found for #{ingredients[:ingredients]}. Please try again with different words."
        must_respond_with :redirect
      end
    end

    it "will redirect with blank search terms" do
      ingredients = nil
      VCR.use_cassette('recipes') do
        get recipes_path, params: ingredients

        expect(flash[:status]).must_equal :danger
        expect(flash[:result_text]).must_equal "Could not find recipes. Invalid seach params."
        must_respond_with :redirect
      end
    end
  end

  describe "show" do
    it "can get the show path with valid id" do
      id = "fbdf4f457c6837f1f3dff02c2db242c0"
      VCR.use_cassette('recipe') do
        get recipe_path(id)

        must_respond_with :ok
      end
    end

    it "redirects and shows errors with invalid id params" do
      id = "hello"
      VCR.use_cassette('recipe') do
        get recipe_path(id)

        expect(flash[:status]).must_equal :danger
        expect(flash[:result_text]).must_equal "Could not find recipe. Please search again."
        must_respond_with :redirect
      end
    end

  end

  describe "main" do
    it "succeeds" do
      get root_path
      must_respond_with :success
    end
  end

end
