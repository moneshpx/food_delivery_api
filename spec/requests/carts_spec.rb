require 'rails_helper'

RSpec.describe "Carts", type: :request do
  describe "Cart Testcases" do
    it("Add to cart") do
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
            price: "30",
            category_id: category.id
          }
        },headers: { 'Authorization' => "Bearer #{jwt_token}" }
      item=JSON.parse(response.body)
      id = item["data"]["id"]
      price = item["data"]["price"].to_i
      post '/add_to_cart',params:{item_id: id,quantity: 2, unit_price: price }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      expect(response).to have_http_status(:created)
    end

    it("Cart not create If user not authenticate") do
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
            price: "30",
            category_id: category.id
          }
        },headers: { 'Authorization' => "Bearer #{jwt_token}" }
      item = JSON.parse(response.body)
      id = item["data"]["id"]
      price = item["data"]["price"].to_i
      post '/add_to_cart',params:{item_id: id, unit_price: price }
      expect(response).to have_http_status(:unauthorized)
    end

    it("All cart list for authorized users") do
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
            price: "30",
            category_id: category.id
          }
        },headers: { 'Authorization' => "Bearer #{jwt_token}" }
      item=JSON.parse(response.body)
      id = item["data"]["id"]
      price = item["data"]["price"].to_i
      post '/add_to_cart',params:{item_id: id,quantity: 2, unit_price: price }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      post '/add_to_cart',params:{item_id: id,quantity: 2, unit_price: price }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      get '/all_carts',headers: { 'Authorization' => "Bearer #{jwt_token}" }
      item = JSON.parse(response.body)
      expect(item.count).to eq(2)
    end

    it("Cart list can not get unauthorized user") do
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
            price: "30",
            category_id: category.id
          }
        },headers: { 'Authorization' => "Bearer #{jwt_token}" }
      item=JSON.parse(response.body)
      id = item["data"]["id"]
      price = item["data"]["price"].to_i
      post '/add_to_cart',params:{item_id: id,quantity: 2, unit_price: price }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      post '/add_to_cart',params:{item_id: id,quantity: 2, unit_price: price }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      get '/all_carts'
      expect(response).to have_http_status(:unauthorized)
    end

    it("Total price for authorized users") do
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
            price: "30",
            category_id: category.id
          }
        },headers: { 'Authorization' => "Bearer #{jwt_token}" }
      item=JSON.parse(response.body)
      id = item["data"]["id"]
      price = item["data"]["price"].to_i
      post '/add_to_cart',params:{item_id: id,quantity: 2, unit_price: price }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      post '/add_to_cart',params:{item_id: id,quantity: 2, unit_price: price }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      get '/cart_total_price',headers: { 'Authorization' => "Bearer #{jwt_token}" }
      item = JSON.parse(response.body)
      expect(item["total_price"].to_i).to eq(120)
    end

    it("Total price not work for unauthorized users") do
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
            price: "30",
            category_id: category.id
          }
        },headers: { 'Authorization' => "Bearer #{jwt_token}" }
      item=JSON.parse(response.body)
      id = item["data"]["id"]
      price = item["data"]["price"].to_i
      post '/add_to_cart',params:{item_id: id,quantity: 2, unit_price: price }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      get '/cart_total_price'
      expect(response).to have_http_status(:unauthorized)
    end

    it("Delete to cart") do
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
            price: "30",
            category_id: category.id
          }
        },headers: { 'Authorization' => "Bearer #{jwt_token}" }
      item=JSON.parse(response.body)
      id = item["data"]["id"]
      price = item["data"]["price"].to_i
      post '/add_to_cart',params:{item_id: id,quantity: 2, unit_price: price }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      expect(response).to have_http_status(:created)
      cartitem = JSON.parse(response.body)
      delete '/delete_to_cart',params:{id: cartitem["cart_item"]["id"]}, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      res = JSON.parse(response.body)
      expect(res["message"]).to eq("Cart item destroyed")
    end

    it("Delete to cart not work if Cart item not found") do
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
            price: "30",
            category_id: category.id
          }
        },headers: { 'Authorization' => "Bearer #{jwt_token}" }
      item=JSON.parse(response.body)
      id = item["data"]["id"]
      price = item["data"]["price"].to_i
      post '/add_to_cart',params:{item_id: id,quantity: 2, unit_price: price }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      expect(response).to have_http_status(:created)
      cartitem = JSON.parse(response.body)
      delete '/delete_to_cart',params:{id: 32}, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      res = JSON.parse(response.body)
      expect(res["message"]).to eq("Cart item not found")
    end

    it("Unauthorize user can not Delete to cart") do
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
            price: "30",
            category_id: category.id
          }
        },headers: { 'Authorization' => "Bearer #{jwt_token}" }
      item=JSON.parse(response.body)
      id = item["data"]["id"]
      price = item["data"]["price"].to_i
      post '/add_to_cart',params:{item_id: id,quantity: 2, unit_price: price }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      expect(response).to have_http_status(:created)
      cartitem = JSON.parse(response.body)
      delete '/delete_to_cart',params:{id: cartitem["cart_item"]["id"]}
      expect(response).to have_http_status(:unauthorized)
    end

    it("Update to cart quantity") do
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
            price: "30",
            category_id: category.id
          }
        },headers: { 'Authorization' => "Bearer #{jwt_token}" }
      item=JSON.parse(response.body)
      id = item["data"]["id"]
      price = item["data"]["price"].to_i
      post '/add_to_cart',params:{item_id: id,quantity: 2, unit_price: price }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      expect(response).to have_http_status(:created)
      cartitem = JSON.parse(response.body)
      put '/update_cart_item_quantity',params:{id: cartitem["cart_item"]["id"],quantity:3 }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      expect(response).to have_http_status(:ok)
    end

    it("quantity must be greater than 0") do
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
            price: "30",
            category_id: category.id
          }
        },headers: { 'Authorization' => "Bearer #{jwt_token}" }
      item=JSON.parse(response.body)
      id = item["data"]["id"]
      price = item["data"]["price"].to_i
      post '/add_to_cart',params:{item_id: id,quantity: 2, unit_price: price }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      expect(response).to have_http_status(:created)
      cartitem = JSON.parse(response.body)
      put '/update_cart_item_quantity',params:{id: cartitem["cart_item"]["id"],quantity:0 }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      res = JSON.parse(response.body)
      expect(res["message"]).to eq("New quantity must be greater than 0")
    end

    it("Authorize user can update quantity") do
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
            price: "30",
            category_id: category.id
          }
        },headers: { 'Authorization' => "Bearer #{jwt_token}" }
      item=JSON.parse(response.body)
      id = item["data"]["id"]
      price = item["data"]["price"].to_i
      post '/add_to_cart',params:{item_id: id,quantity: 2, unit_price: price }, headers: { 'Authorization' => "Bearer #{jwt_token}" }
      expect(response).to have_http_status(:created)
      cartitem = JSON.parse(response.body)
      put '/update_cart_item_quantity',params:{id: cartitem["cart_item"]["id"],quantity:3 }
      expect(response).to have_http_status(:unauthorized)
    end
  end
end  
