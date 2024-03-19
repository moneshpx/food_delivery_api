require 'rails_helper'
RSpec.describe "Foods Details", type: :request do
  describe "Food details Testcases" do
    it("Food details get") do
      user = User.create(email: 'test@example.com', password: 'password', role: 'seller')
      # Log in the user and retrieve the authentication token
      post '/login', params: { user: { email: 'test@example.com', password: 'password' } }
      # Set the authorization header with the token
      food1 = Food.create(name: "margrite piza", detail: "xyz", price: 555, image_url: "jdfkh", ingredints_basic: "test, test2", fruits: "mango banana", user_id: user.id)
      get '/food_details', params:{id: food1.id}
      expect(response).to have_http_status(:ok)
    end

    it('Food not found') do
      get '/food_details', params:{id: 3}
      response_body = JSON.parse(response.body)['error']
      expect(response_body).to eq('Food not found')
    end
  end
end