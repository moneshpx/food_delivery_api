require 'rails_helper'
RSpec.describe "FoodOffers", type: :request do
  describe "Offers rspec" do
    it("Offers create rspec") do
      post '/signup', params: { user: { email: 'testnew@example.com', password: 'password', name: 'testnes' } }
      expect(response).to have_http_status(:ok)
      post '/login', params: { user: { email: 'testnew@example.com', password: 'password' } }
      expect(response).to have_http_status(:ok)
      jwt_token = response.headers['Authorization'].split(' ').last
      post '/create_restaurant',params: {restaurant: {name: "Food wila Indore",
        image: "fjdkjh",
        working_days: "monday",
        address: "3456 arihant nagar",
        open_time: "10AM",
        close_time: "8PM",
        documents: "fkjdf kdfjk f",
        details: "This is the One of the best restaurent for reginable cost",
        owner_name: "Jesson",
        email: "Jesson@gmail.com",
        mobile_number: "3456789"}}, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      restaurant=JSON.parse(response.body)
      post '/offer_create', params:{offer:{title: "first offer", percentage_discount:32, code: "fsd2",valid_from:
        "valid_until", valid_until: "12/05/2024", restaurant_id: restaurant['id'] }}, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      expect(response).to have_http_status(:created)
    end

    it("Offers create rspec restaurant id must exist") do
      post '/signup', params: { user: { email: 'testnew@example.com', password: 'password', name: 'testnes' } }
      expect(response).to have_http_status(:ok)
      post '/login', params: { user: { email: 'testnew@example.com', password: 'password' } }
      expect(response).to have_http_status(:ok)
      jwt_token = response.headers['Authorization'].split(' ').last
      post '/offer_create', params:{offer:{title: "first offer", percentage_discount:32, code: "fsd2",valid_from:
        "valid_until", valid_until: "12/05/2024" }}, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it("all offers get of the restaurants") do
      post '/signup', params: { user: { email: 'testnew@example.com', password: 'password', name: 'testnes' } }
      expect(response).to have_http_status(:ok)
      post '/login', params: { user: { email: 'testnew@example.com', password: 'password' } }
      expect(response).to have_http_status(:ok)
      jwt_token = response.headers['Authorization'].split(' ').last
      get '/all_offers', headers: { 'Authorization' => "Bearer #{jwt_token}" }
      expect(response).to have_http_status(:ok)
    end

    it("Show specific offer") do
      post '/signup', params: { user: { email: 'testnew@example.com', password: 'password', name: 'testnes' } }
      expect(response).to have_http_status(:ok)
      post '/login', params: { user: { email: 'testnew@example.com', password: 'password' } }
      expect(response).to have_http_status(:ok)
      jwt_token = response.headers['Authorization'].split(' ').last
      post '/create_restaurant',params: {restaurant: {name: "Food wila Indore",
        image: "fjdkjh",
        working_days: "monday",
        address: "3456 arihant nagar",
        open_time: "10AM",
        close_time: "8PM",
        documents: "fkjdf kdfjk f",
        details: "This is the One of the best restaurent for reginable cost",
        owner_name: "Jesson",
        email: "Jesson@gmail.com",
        mobile_number: "3456789"}}, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      restaurant=JSON.parse(response.body)
      post '/offer_create', params:{offer:{title: "first offer", percentage_discount:32, code: "fsd2",valid_from:
        "valid_until", valid_until: "12/05/2024", restaurant_id: restaurant['id'] }}, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      expect(response).to have_http_status(:created)
      offer=JSON.parse(response.body)
      get '/offer_show',params:{id: offer["id"]}, headers: { 'Authorization' => "Bearer #{jwt_token}" }
    end
  end
end
