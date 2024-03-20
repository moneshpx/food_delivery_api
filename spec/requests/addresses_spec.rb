require 'rails_helper'

RSpec.describe "Addresses", type: :request do
  describe "Address Testcases" do
    it('Create the address Authorized user') do
      user = User.create(email: 'test@example.com', password: 'password')
      # Log in the user and retrieve the authentication token
      post '/login', params: { user: { email: 'test@example.com', password: 'password' } }
      jwt_token = response.headers['Authorization'].split(' ').last # Assuming your login endpoint returns a token
      # Set the authorization header with the token
      post '/new_address', params: { address: { address: "402 aradhna nagar", street: "gali no4", landmark: "World gym", postal_code: 123456, user_id: user.id } }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      expect(response).to have_http_status(:created)
    end

    it('The address field not blank') do
      user = User.create(email: 'test@example.com', password: 'password')
      # Log in the user and retrieve the authentication token
      post '/login', params: { user: { email: 'test@example.com', password: 'password' } }
      jwt_token = response.headers['Authorization'].split(' ').last # Assuming your login endpoint returns a token
      # Set the authorization header with the token
      post '/new_address', params: { address: { street: "gali no4", landmark: "World gym", postal_code: 123456, user_id: user.id } }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it('Not Create the address Unauthorized user') do
      user = User.create(email: 'test@example.com', password: 'password')
      # Log in the user and retrieve the authentication token
      post '/login', params: { user: { email: 'test@example.com', password: 'password' } }
      post '/new_address', params: { address: { address: "402 aradhna nagar", street: "gali no4", landmark: "World gym", postal_code: 123456, user_id: user.id } }
      expect(response).to have_http_status(:unauthorized)
    end

    it('User list of the addresses') do
      user = User.create(email: 'test@example.com', password: 'password')
      # Log in the user and retrieve the authentication token
      post '/login', params: { user: { email: 'test@example.com', password: 'password' } }
      jwt_token = response.headers['Authorization'].split(' ').last # Assuming your login endpoint returns a token
      # Set the authorization header with the token
      post '/new_address', params: { address: { address: "402 aradhna nagar", street: "gali no4", landmark: "World gym", postal_code: 123456, user_id: user.id } }, headers: { 'Authorization' => "Bearer #{jwt_token}" } 
      post '/new_address', params: { address: { address: "420 aradhna nagar", street: "gali no4", landmark: "World gym", postal_code: 123456, user_id: user.id } }, headers: { 'Authorization' => "Bearer #{jwt_token}" }  
      expect(user.addresses.count).to eq(2)
    end

    it 'Authorize user Updates the address' do
      # Create a user
      user = User.create(email: 'test@example.com', password: 'password')
      # Log in the user and retrieve the authentication token
      post '/login', params: { user: { email: 'test@example.com', password: 'password' } }
      jwt_token = response.headers['Authorization'].split(' ').last # Assuming your login endpoint returns a token

      # Create an address for the user
      post '/new_address', params: { address: { address: "402 aradhna nagar", street: "gali no4", landmark: "World gym", postal_code: 123456, user_id: user.id } }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      address_id = JSON.parse(response.body)['id']
      # Update the address
      patch "/update_address/#{address_id}", params: { address: { street: "4999 Arihant nagar" } }, headers: { 'Authorization' => "Bearer #{jwt_token}" }

      # Assert the response
      expect(response).to have_http_status(:ok)
    end

    it 'Unauthorized user can not Updates the address' do
      # Create a user
      user = User.create(email: 'test@example.com', password: 'password')
      # Log in the user and retrieve the authentication token
      post '/login', params: { user: { email: 'test@example.com', password: 'password' } }
      jwt_token = response.headers['Authorization'].split(' ').last # Assuming your login endpoint returns a token

      # Create an address for the user
      post '/new_address', params: { address: { address: "402 aradhna nagar", street: "gali no4", landmark: "World gym", postal_code: 123456, user_id: user.id } }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      address_id = JSON.parse(response.body)['id']
      # Update the address
      patch "/update_address/#{address_id}", params: { address: { street: "4999 Arihant nagar" } }

      # Assert the response
      expect(response).to have_http_status(:unauthorized)
    end

    it 'Bad request hit by user' do
      # Create a user
      user = User.create(email: 'test@example.com', password: 'password')
      # Log in the user and retrieve the authentication token
      post '/login', params: { user: { email: 'test@example.com', password: 'password' } }
      jwt_token = response.headers['Authorization'].split(' ').last # Assuming your login endpoint returns a token

      # Create an address for the user
      post '/new_address', params: { address: { address: "402 aradhna nagar", street: "gali no4", landmark: "World gym", postal_code: 123456, user_id: user.id } }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      address_id = JSON.parse(response.body)['id']
      # Update the address
      patch "/update_address/#{address_id}", params: { xyz: "4999 Arihant nagar"  }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      # Assert the response
      expect(response).to have_http_status(:bad_request)
    end
  end
end