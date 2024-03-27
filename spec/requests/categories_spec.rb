require 'rails_helper'

RSpec.describe "Categories", type: :request do
  describe "Categories testcases" do
    it("So the list of Categories") do
      category = Category.create(name: "Pizza",image: "fjdkfdfdd")
      get '/all_category'
      category = JSON.parse(response.body)
      expect(category.first["name"]).to eq("pizza")
    end
  end
end
