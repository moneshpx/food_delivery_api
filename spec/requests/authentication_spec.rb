require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  
  describe 'POST /signup' do
    it 'creates a new user' do
      post '/signup', params: { user: { email: 'test@example.com', password: 'password', name: 'johnson' } }
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /login' do
    it 'logs in the user' do
      user = User.create(email: 'test@example.com', password: 'password')
      post '/login', params: { user: { email: 'test@example.com', password: 'password' } }
      expect(response).to have_http_status(:ok)
    end
  end
end
