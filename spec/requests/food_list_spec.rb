require 'rails_helper'
require 'faker'
RSpec.describe "Foods", type: :request do
  describe "Food List Testcases" do
    it('returns the food list of the current user') do 
      # Create a seller user and sign in
      user = User.create(email: 'test@example.com', password: 'password', role: 'seller')
      # Log in the user and retrieve the authentication token
      post '/login', params: { user: { email: 'test@example.com', password: 'password' } }
      jwt_token = response.headers['Authorization'].split(' ').last # Assuming your login endpoint returns a token
      # Set the authorization header with the token
      food1 = post '/food_create', params: { food: { name: "margrite piza", detail: "xyz", price: 555, image_url: "jdfkh", ingredints_basic: "test, test2", fruits: "mango banana", user_id: user.id } }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      food2 = post '/food_create', params: { food: { name: "margrite piza", detail: "xyz", price: 555, image_url: "jdfkh", ingredints_basic: "test, test2", fruits: "mango banana", user_id: user.id } }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      # Make the request
      get '/food_list'
      
      # Check the response
      expect(response).to have_http_status(:ok)
      # Parse the JSON response and check if it contains the seller's food items
      expect(JSON.parse(response.body).count).to eq(2)
    end
  end
end