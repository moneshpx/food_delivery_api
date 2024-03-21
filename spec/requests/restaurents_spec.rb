require 'rails_helper'

RSpec.describe "Restaurents", type: :request do
  describe "Restaurants Testcases" do
    it('Restaurants create') do
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
      expect(response).to have_http_status(:created)
    end

    it('Unauthorized user can not create Restaurants') do
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
        mobile_number: "3456789"}}
      expect(response).to have_http_status(:unauthorized)
    end

    it('Without owner_name can not create Restaurants') do
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
        email: "Jesson@gmail.com",
        mobile_number: "3456789"}}, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
