require 'rails_helper'

RSpec.describe 'PasswordReset', type: :request do
  describe 'PUT #update' do
    context 'with valid code and not expired' do
      it 'resets the password' do
        user = User.create(email: "mytest@gmail.com", password: "123456",reset_password_sent_at: Time.now, verification_code: '1234')
        post '/verify_code', params: { email: 'mytest@gmail.com', code: '1234' } 
        put '/password_resets', params: { email: user.email, verification_code: user.verification_code, password: 654321}
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['message']).to eq('Password reset successful')
      end
    end

    context 'with invalid or expired code' do
      it 'returns unprocessable_entity' do
        user = User.create(email: "mytest@gmail.com", password: "123456",reset_password_sent_at: Time.now ,verification_code: '1234')
        user.update(reset_password_sent_at: 3.hours.ago)
        put '/password_resets', params: { email: user.email, verification_code: user.verification_code, password: 123456}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to eq('Invalid or expired verification code')
      end
    end
  end
end