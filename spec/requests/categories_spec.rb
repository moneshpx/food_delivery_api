require 'rails_helper'

RSpec.describe "Categories", type: :request do
  describe "Categories testcases" do
    it("So the list of Categories") do
      category = Category.create(name: "Pizza",image: "fjdkfdfdd")
      get '/all_category'
      category = JSON.parse(response.body)
      expect(category.first["name"]).to eq("pizza")
    end

    it("Search the Categories by name") do
      category = Category.create(name: "Pizza",image: "fjdkfdfdd")
      get '/categories/search',params:{query: "pizza"}
      category = JSON.parse(response.body)
      expect(category.first["name"]).to eq("pizza")
    end

    it("If category not found")do
      get '/categories/search',params:{query: "burger"}
      category = JSON.parse(response.body)
      expect(category["message"]).to eq("Categories not found")
    end
  end
end
