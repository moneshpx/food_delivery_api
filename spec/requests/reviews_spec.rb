require 'rails_helper'

RSpec.describe "Reviews", type: :request do
  describe "Review Testcases" do
    it("Review create for restaurant") do
      post '/signup', params: { user: { email: 'testnew@example.com', password: 'password', name: 'testnes' } }
      expect(response).to have_http_status(:ok)
      post '/login', params: { user: { email: 'testnew@example.com', password: 'password' } }
      expect(response).to have_http_status(:ok)
      jwt_token = response.headers['Authorization'].split(' ').last
      post '/create_restaurant',params: {restaurant: {name: "Food wila Indore",
        image: "fjdkjh",
        working_days: "monday",
        address: "3456 arihant nagar",
        open_time: "10AM",
        close_time: "8PM",
        documents: "fkjdf kdfjk f",
        details: "This is the One of the best restaurent for reginable cost",
        owner_name: "Jesson",
        email: "Jesson@gmail.com",
        mobile_number: "3456789"}}, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      restaurant =  JSON.parse(response.body)
      restaurant_id = restaurant["id"]
      post "/create_review", params: {  restaurant_id: restaurant_id, review: {rating: 4} }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      expect(response).to have_http_status(:created)
    end

    it("Unauthorize user can not create Review") do
      post '/signup', params: { user: { email: 'testnew@example.com', password: 'password', name: 'testnes' } }
      expect(response).to have_http_status(:ok)
      post '/login', params: { user: { email: 'testnew@example.com', password: 'password' } }
      expect(response).to have_http_status(:ok)
      jwt_token = response.headers['Authorization'].split(' ').last
      post '/create_restaurant',params: {restaurant: {name: "Food wila Indore",
        image: "fjdkjh",
        working_days: "monday",
        address: "3456 arihant nagar",
        open_time: "10AM",
        close_time: "8PM",
        documents: "fkjdf kdfjk f",
        details: "This is the One of the best restaurent for reginable cost",
        owner_name: "Jesson",
        email: "Jesson@gmail.com",
        mobile_number: "3456789"}}, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      restaurant =  JSON.parse(response.body)
      restaurant_id = restaurant["id"]
      post "/create_review", params: {  restaurant_id: restaurant_id, review: {rating: 4} }
    end

    it("Review create") do
      post '/signup', params: { user: { email: 'testnew@example.com', password: 'password', name: 'testnes' } }
      expect(response).to have_http_status(:ok)
      post '/login', params: { user: { email: 'testnew@example.com', password: 'password' } }
      expect(response).to have_http_status(:ok)
      jwt_token = response.headers['Authorization'].split(' ').last
      post '/create_restaurant',params: {restaurant: {name: "Food wila Indore",
        image: "fjdkjh",
        working_days: "monday",
        address: "3456 arihant nagar",
        open_time: "10AM",
        close_time: "8PM",
        documents: "fkjdf kdfjk f",
        details: "This is the One of the best restaurent for reginable cost",
        owner_name: "Jesson",
        email: "Jesson@gmail.com",
        mobile_number: "3456789"}}, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      restaurant =  JSON.parse(response.body)
      restaurant_id = restaurant["id"]
      post "/create_review", params: {  restaurant_id: restaurant_id, review: {rating: 4} }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      expect(response).to have_http_status(:created)
    end

    it("Review create for item") do
      post '/signup', params: { user: { email: 'testnew@example.com', password: 'password', name: 'testnes' } }
      expect(response).to have_http_status(:ok)
      post '/login', params: { user: { email: 'testnew@example.com', password: 'password' } }
      expect(response).to have_http_status(:ok)
      jwt_token = response.headers['Authorization'].split(' ').last
      post '/create_restaurant',params: {restaurant: {name: "Food wila Indore",
        image: "fjdkjh",
        working_days: "monday",
        address: "3456 arihant nagar",
        open_time: "10AM",
        close_time: "8PM",
        documents: "fkjdf kdfjk f",
        details: "This is the One of the best restaurent for reginable cost",
        owner_name: "Jesson",
        email: "Jesson@gmail.com",
        mobile_number: "3456789"}}, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      category = Category.create(name:"pizaa")
      restaurant =  JSON.parse(response.body)
      restaurant_id = restaurant["id"]
      post '/item_create', params: {restaurant_id: restaurant['id'],
          item: {
            image_url: "fklsdn",
            name: "Second Burger",
            detail: "This is one of the best burgers",
            price: "345667",
            category_id: category.id
          }
        },
        headers: { 'Authorization' => "Bearer #{jwt_token}" }
      item =  JSON.parse(response.body)
      item_id = item["data"]["id"]
      post "/create_review", params: {  item_id: item_id, review: {rating: 4} }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      expect(response).to have_http_status(:created)
    end

    it("Review not create with valid params") do
      post '/signup', params: { user: { email: 'testnew@example.com', password: 'password', name: 'testnes' } }
      expect(response).to have_http_status(:ok)
      post '/login', params: { user: { email: 'testnew@example.com', password: 'password' } }
      expect(response).to have_http_status(:ok)
      jwt_token = response.headers['Authorization'].split(' ').last
      post '/create_restaurant',params: {restaurant: {name: "Food wila Indore",
        image: "fjdkjh",
        working_days: "monday",
        address: "3456 arihant nagar",
        open_time: "10AM",
        close_time: "8PM",
        documents: "fkjdf kdfjk f",
        details: "This is the One of the best restaurent for reginable cost",
        owner_name: "Jesson",
        email: "Jesson@gmail.com",
        mobile_number: "3456789"}}, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      post "/create_review", params: { review: {rating: 4} }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      res=JSON.parse(response.body)
      expect(res["message"]).to eq("Invalid params provided")
    end

    it("Average restaurant reviews") do
      post '/signup', params: { user: { email: 'testnew@example.com', password: 'password', name: 'testnes' } }
      expect(response).to have_http_status(:ok)
      post '/login', params: { user: { email: 'testnew@example.com', password: 'password' } }
      expect(response).to have_http_status(:ok)
      jwt_token = response.headers['Authorization'].split(' ').last
      post '/create_restaurant',params: {restaurant: {name: "Food wila Indore",
        image: "fjdkjh",
        working_days: "monday",
        address: "3456 arihant nagar",
        open_time: "10AM",
        close_time: "8PM",
        documents: "fkjdf kdfjk f",
        details: "This is the One of the best restaurent for reginable cost",
        owner_name: "Jesson",
        email: "Jesson@gmail.com",
        mobile_number: "3456789"}}, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      restaurant =  JSON.parse(response.body)
      restaurant_id = restaurant["id"]
      post "/create_review", params: {  restaurant_id: restaurant_id, review: {rating: 4} }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      expect(response).to have_http_status(:created)
      get '/restaurant_reviews',params: {restaurant_id: restaurant_id}
      expect(response.body).to eq("4.0")
    end

    it("Average item reviews") do
      post '/signup', params: { user: { email: 'testnew@example.com', password: 'password', name: 'testnes' } }
      expect(response).to have_http_status(:ok)
      post '/login', params: { user: { email: 'testnew@example.com', password: 'password' } }
      expect(response).to have_http_status(:ok)
      jwt_token = response.headers['Authorization'].split(' ').last
      post '/create_restaurant',params: {restaurant: {name: "Food wila Indore",
        image: "fjdkjh",
        working_days: "monday",
        address: "3456 arihant nagar",
        open_time: "10AM",
        close_time: "8PM",
        documents: "fkjdf kdfjk f",
        details: "This is the One of the best restaurent for reginable cost",
        owner_name: "Jesson",
        email: "Jesson@gmail.com",
        mobile_number: "3456789"}}, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      category = Category.create(name:"pizaa")
      restaurant =  JSON.parse(response.body)
      restaurant_id = restaurant["id"]
      post '/item_create', params: {restaurant_id: restaurant['id'],
          item: {
            image_url: "fklsdn",
            name: "Second Burger",
            detail: "This is one of the best burgers",
            price: "345667",
            category_id: category.id
          }
        },
        headers: { 'Authorization' => "Bearer #{jwt_token}" }
      item =  JSON.parse(response.body)
      item_id = item["data"]["id"]
      post "/create_review", params: {  item_id: item_id, review: {rating: 4} }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      expect(response).to have_http_status(:created)
      get '/item_reviews',params: {item_id: item_id}
      expect(response.body).to eq("4.0")
    end

    it("Top rated restaurant") do
      post '/signup', params: { user: { email: 'testnew@example.com', password: 'password', name: 'testnes' } }
      expect(response).to have_http_status(:ok)
      post '/login', params: { user: { email: 'testnew@example.com', password: 'password' } }
      expect(response).to have_http_status(:ok)
      jwt_token = response.headers['Authorization'].split(' ').last
      post '/create_restaurant',params: {restaurant: {name: "Food wila Indore",
        image: "fjdkjh",
        working_days: "monday",
        address: "3456 arihant nagar",
        open_time: "10AM",
        close_time: "8PM",
        documents: "fkjdf kdfjk f",
        details: "This is the One of the best restaurent for reginable cost",
        owner_name: "Jesson",
        email: "Jesson@gmail.com",
        mobile_number: "3456789"}}, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      restaurant =  JSON.parse(response.body)
      restaurant_id = restaurant["id"]
      post "/create_review", params: {  restaurant_id: restaurant_id, review: {rating: 4} }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      expect(response).to have_http_status(:created)
      get '/top_rated_restaurant'
      res=JSON.parse(response.body)
      expect(res.count).to eq(1)
    end
  end
end
