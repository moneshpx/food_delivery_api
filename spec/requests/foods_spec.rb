require 'rails_helper'

RSpec.describe "Foods", type: :request do
  describe "Food Testcases" do
    describe "Create food" do
      it('Create the food') do 
        user = User.create(email: 'test@example.com', password: 'password', role: 'seller')
        # Log in the user and retrieve the authentication token
        post '/login', params: { user: { email: 'test@example.com', password: 'password' } }
        jwt_token = response.headers['Authorization'].split(' ').last # Assuming your login endpoint returns a token
        # Set the authorization header with the token
        post '/food_create', params: { food: { name: "margrite piza", detail: "xyz", price: 555, image_url: "jdfkh", ingredints_basic: "test, test2", fruits: "mango banana", user_id: user.id } }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
        expect(response).to have_http_status(:created)
      end

      it('Normal user not create the food') do
        user = User.create(email: 'test@example.com', password: 'password')
        # Log in the user and retrieve the authentication token
        post '/login', params: { user: { email: 'test@example.com', password: 'password' } }
        jwt_token = response.headers['Authorization'].split(' ').last # Assuming your login endpoint returns a token
        # Set the authorization header with the token
        post '/food_create', params: { food: { name: "margrite piza", detail: "xyz", price: 555, image_url: "jdfkh", ingredints_basic: "test, test2", fruits: "mango banana", user_id: user.id } }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
        response_message = JSON.parse(response.body)['message']  
        expect(response_message).to eq('Food only create by seller')
      end

      it('Food not create') do
        user = User.create(email: 'test@example.com', password: 'password', role: 'seller' )
        # Log in the user and retrieve the authentication token
        post '/login', params: { user: { email: 'test@example.com', password: 'password' } }
        jwt_token = response.headers['Authorization'].split(' ').last # Assuming your login endpoint returns a token
        # Set the authorization header with the token
        post '/food_create', params: { food: { detail: "xyz", price: 555, image_url: "jdfkh", ingredints_basic: "test, test2", fruits: "mango banana"} }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
