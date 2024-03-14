require 'rails_helper'

RSpec.describe "UsersController",  type: :request do
  describe 'POST #verify_code' do
    it 'verifies code and returns success message' do
      user = User.create(email: "mytest@gmail.com", password: "123456", verification_code: '1234')
      post '/verify_code', params: { email: 'mytest@gmail.com', code: '1234' } 
      response_data = JSON.parse(response.body)
      expect(response_data['message']).to eq('Verification successful')
      expect(response).to have_http_status(:success)
    end

    it 'Invalid verification code' do
      user = User.create(email: "mytest@gmail.com",password: "123456",verification_code: '1234')
      post '/verify_code', params: {  email: 'mytest@gmail.com', verification_code: '1244'  }
      expect(JSON.parse(response.body)).to eq('error' => 'Invalid verification code' )
    end
  end
end