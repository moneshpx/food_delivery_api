require 'rails_helper'

RSpec.describe "Items", type: :request do
  describe "Item Test cases" do
    it('Restaurant user create Item') do
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
      expect(response).to have_http_status(:created)
      restaurant=JSON.parse(response.body)
      category = Category.create(name:"pizaa")
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
      expect(response).to have_http_status(:ok)
    end

    it('Without Item name can not create the Item') do
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
      expect(response).to have_http_status(:created)
      restaurant=JSON.parse(response.body)
      category = Category.create(name:"pizaa")
      post '/item_create', params: {restaurant_id: restaurant['id'],
          item: {
            image_url: "fklsdn",
            detail: "This is one of the best burgers",
            price: "345667",
            category_id: category.id
          }
        },
        headers: { 'Authorization' => "Bearer #{jwt_token}" }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it('Unauthorized user can not create Item') do
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
      expect(response).to have_http_status(:created)
      restaurant=JSON.parse(response.body)
      category = Category.create(name:"pizaa")
      post '/item_create', params: {restaurant_id: restaurant['id'],
          item: {
            image_url: "fklsdn",
            name: "Second Burger",
            detail: "This is one of the best burgers",
            price: "345667",
            category_id: category.id
          }
        }
      expect(response).to have_http_status(:unauthorized)
    end

    it('user listing') do

     post '/signup', params: {user: {email: "test@email.com", password:"123456", name:"tester"}}
     expect(response).to have_http_status(:ok)
     post '/login', params: {user: {email:"test@email.com", password:"123456"}}
     expect(response).to have_http_status(:ok)
     jwt_token = response.headers['Authorization'].split(' ').last
     post '/create_restaurant', params: {restaurant: {
        name:'Apna Khana',
        image: "fjdkjh",
        working_days: "monday",
        address: "3456 arihant nagar",
        open_time: "10AM",
        close_time: "8PM",
        documents: "fkjdf kdfjk f",
        details: "This is the One of the best restaurent for reginable cost",
        owner_name: "Jesson",
        email: "Jesson@gmail.com",
        mobile_number: "3456789" }}, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      expect(response).to have_http_status(:created)
      restaurant=JSON.parse(response.body)
      category = Category.create(name:"pizaa")
      post '/item_create', params: {restaurant_id: restaurant['id'],
          item: {
            image_url: "fklsdn",
            name: "Second Burger",
            detail: "This is one of the best burgers",
            price: "345667",
            category_id: category.id
          }
        },headers: { 'Authorization' => "Bearer #{jwt_token}" }
      post '/item_create', params: {restaurant_id: restaurant['id'],
          item: {
            image_url: "tyu",
            name: "third Burger",
            detail: "This is one of the best burgers",
            price: "345667",
            category_id: category.id
          }
        },headers: { 'Authorization' => "Bearer #{jwt_token}" }
      expect(response).to have_http_status(:ok)
      get '/item_list', params: {restaurant_id: restaurant['id']
      },headers: { 'Authorization' => "Bearer #{jwt_token}" }
      item_list=JSON.parse(response.body)
      expect(item_list.count).to eq(2)
    end

    it 'Items Details' do
     post '/signup', params: {user: {email: "test@email.com", password:"123456", name:"tester"}}
     expect(response).to have_http_status(:ok)
     post '/login', params: {user: {email:"test@email.com", password:"123456"}}
     expect(response).to have_http_status(:ok)
     jwt_token = response.headers['Authorization'].split(' ').last
     post '/create_restaurant', params: {restaurant: {
        name:'Apna Khana',
        image: "fjdkjh",
        working_days: "monday",
        address: "3456 arihant nagar",
        open_time: "10AM",
        close_time: "8PM",
        documents: "fkjdf kdfjk f",
        details: "This is the One of the best restaurent for reginable cost",
        owner_name: "Jesson",
        email: "Jesson@gmail.com",
        mobile_number: "3456789" }}, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      expect(response).to have_http_status(:created)
      restaurant=JSON.parse(response.body)
      category = Category.create(name:"pizaa")
      post '/item_create', params: {restaurant_id: restaurant['id'],
          item: {
            image_url: "fklsdn",
            name: "Second Burger",
            detail: "This is one of the best burgers",
            price: "345667",
            category_id: category.id
          }
        },headers: { 'Authorization' => "Bearer #{jwt_token}" }
      post '/item_create', params: {restaurant_id: restaurant['id'],
          item: {
            image_url: "tyu",
            name: "third Burger",
            detail: "This is one of the best burgers",
            price: "345667",
            category_id: category.id
          }
        },headers: { 'Authorization' => "Bearer #{jwt_token}" }
      expect(response).to have_http_status(:ok)
      get '/item_list', params: {restaurant_id: restaurant['id']
      },headers: { 'Authorization' => "Bearer #{jwt_token}" }
      item_list=JSON.parse(response.body)
      expect(item_list.count).to eq(2)
      get '/item_details', params: {id:item_list.first['id']}
      expect(response).to have_http_status(:ok)
     end
  end
end