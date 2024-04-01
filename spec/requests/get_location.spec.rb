require 'rails_helper'

RSpec.describe "Locations", type: :request do
  describe "Locations testcases" do
    it "Check the locations" do
      get '/get_locations',params: { address: "Indore"}
      res =  JSON.parse(response.body)
      expect(res.first["data"]["name"]).to eq("Indore")
    end

    it "Locations not found" do
      get '/get_locations',params: { address: "fndfjd"}
      res =  JSON.parse(response.body)
      expect(res["message"]).to eq("locations not found")
    end

  end
end
