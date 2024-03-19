require 'rails_helper'

RSpec.describe "Profiles", type: :request do
  describe "Profile Testcases" do
    
    it('Profile get info') do
      user = User.create(email: 'test@example.com', password: 'password')
      post '/login', params: { user: { email: 'test@example.com', password: 'password' } }
      jwt_token = response.headers['Authorization'].split(' ').last
      get '/profile_info', headers: { 'Authorization' => "Bearer #{jwt_token}" }
      expect(response).to have_http_status(:ok)
    end 

    it('User not authorized Profile info not get') do
      get '/profile_info'
      expect(response).to have_http_status(:unauthorized)
    end

    it('Profile update') do
      # Create a user
      user = User.create(email: 'test@example.com', password: 'password')

      # Log in the user and obtain the JWT token
      post '/login', params: { user: { email: 'test@example.com', password: 'password' } }
      jwt_token = response.headers['Authorization'].split(' ').last

      # Ensure the JWT token is present
      expect(jwt_token).not_to be_nil

      # Update the profile with the authenticated user
      patch '/update_profile', params: { user: { bio: "I am the food lover" } }, headers: { 'Authorization' => "Bearer #{jwt_token}" }

      # Check if the profile was successfully updated
      expect(response).to have_http_status(:success)

      user.reload
      expect(user.bio).to eq("I am the food lover")
    end

    it "returns unprocessable entity when invalid parameters are provided" do
      # Create a user
      user = User.create(email: 'test@example.com', password: 'password')

      # Log in the user and obtain the JWT token
      post '/login', params: { user: { email: 'test@example.com', password: 'password' } }
      jwt_token = response.headers['Authorization'].split(' ').last

      # Ensure the JWT token is present
      expect(jwt_token).not_to be_nil

      # Attempt to update the profile with invalid parameters
      patch '/update_profile', params: { xyz: 1234567 }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      # Check that the response status is unprocessable entity
      expect(response).to have_http_status(:bad_request)
    end
  end
end
