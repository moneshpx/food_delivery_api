require 'rails_helper'
require 'jwt'

RSpec.describe 'Authentication', type: :request do
  describe 'POST /signup' do
    it 'creates a new user' do
      post '/signup', params: { user: { email: 'testnew@example.com', password: 'password', name: 'testnes' } }
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /login' do
    it 'logs in the user' do
      user = User.create(email: 'test@example.com', password: 'password')
      post '/login', params: { user: { email: 'test@example.com', password: 'password' } }
      expect(response).to have_http_status(:ok)
    end

    it 'returns unauthorized with invalid credentials' do
      user = User.create(email: 'test@example.com', password: 'password')
      post '/login', params: { email: 'invalid@example.com', password: 'invalid_password' }
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "POST /logout" do
    context "when user is logged in" do
      it "logs out the user" do
        # Create the user
        user = User.create(email: 'test@example.com', password: 'password')
        
        # Log in the user
        post '/login', params: { user: { email: 'test@example.com', password: 'password' } }
        
        # Obtain the JWT token
        jwt_token = response.headers['Authorization'].split(' ').last
        
        # Logout the user
        delete logout_path, headers: { 'Authorization' => "Bearer #{jwt_token}" }
        
        expect(response).to have_http_status(200) # Assuming logout returns 200
        
      end
    end
    
    context "when user is not logged in" do
      it "returns unauthorized" do
        delete '/logout'
        
        expect(response).to have_http_status(401) # Assuming unauthorized access returns 401 Unauthorized
      end
    end
  end
end
