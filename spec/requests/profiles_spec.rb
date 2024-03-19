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
      user = User.create(email: 'test@example.com', password: 'password')
      post '/login', params: { user: { email: 'test@example.com', password: 'password' } }
      jwt_token = response.headers['Authorization'].split(' ').last
      patch '/profile_update', params:{user:{bio: "I am the food lover"}}, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      byebug
    end
  end
end
