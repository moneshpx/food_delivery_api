
require 'rails_helper'

RSpec.describe ForgotPasswordsController, type: :controller do
  describe 'POST #forgot_password' do
    context 'when user exists with provided email' do
      let(:user) { create(:user, email: 'testfact@example.com') }

      before do
        allow(User).to receive(:find_by_email).and_return(user)
        allow(subject).to receive(:generate_otp).and_return('123456') # Stubbing generate_otp method
        allow(ForgotPasswordMailer).to receive(:reset_password_token).and_return(double(deliver_now: true)) # Stubbing mailer
      end

      it 'generates verification code, updates user, and sends email' do
        post :forgot_password, params: { email: 'testfact@example.com' }

        expect(user.reload.verification_code).to eq(123456)
        expect(ForgotPasswordMailer).to have_received(:reset_password_token).with(user)
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)).to eq({ 'message' => 'Verification code sent successfully' })
      end
    end

    context 'when no user exists with provided email' do
      before do
        allow(User).to receive(:find_by_email).and_return(nil)
      end

      it 'returns error message' do
        post :forgot_password, params: { email: 'nonexistent@example.com' }

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to eq({ 'error' => 'No User found with the provided email' })
      end
    end
  end
end