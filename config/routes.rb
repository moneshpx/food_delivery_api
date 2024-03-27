Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      registration: 'signup'
    },
    controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
    }
  ###########User routes ###########
  delete '/logout', to: 'users/sessions#destroy', as: :logout
  post '/forgot_password', to: 'forgot_passwords#forgot_password'
  post '/verify_code', to: 'forgot_passwords#verify_code'
  put '/password_resets', to: 'forgot_passwords#update'

  ###########Food routes ###########
  post '/food_create', to: 'foods#create'
  get '/food_list', to: 'foods#food_list'
  get '/food_details', to: 'foods#food_details'

  ###########Profile routes ###########
  get '/profile_info', to: 'profiles#profile_info'
  patch '/update_profile', to: 'profiles#update_profile'

  ###########Address routes ###########
  post '/new_address', to: 'addresses#new_address'
  get '/my_address', to: 'addresses#my_address'
  patch '/update_address/:id', to: 'addresses#update_address'

  ###########Restaurant routes###########
  post '/create_restaurant', to: "restaurants#create_restaurant"
  get '/restaurant_details', to: "restaurants#restaurant_details"
 
  ###########Item routes ###########
  post '/item_create', to: 'items#item_create'
  patch '/item_update', to: 'items#item_update'
  get '/item_list',to: "items#item_list"
  get '/item_details', to: "items#item_details"
  get '/items/search', to: 'items#search'

  ############Food offer routes ####
  get '/all_offers', to: 'food_offers#all_offers'
  post '/offer_create', to: 'food_offers#offer_create'
  get '/offer_show', to: 'food_offers#offer_show'

  ###########Categories routes #####
  get '/all_category', to: 'categories#all_category'
  get '/categories/search', to: 'categories#search'

  ########### Add to cart routes ###
  post 'add_to_cart/:item_id', to: 'carts#add_to_cart'
  get '/cart_total_price', to: 'carts#cart_total_price'
  get '/all_carts', to: 'carts#all_carts'
end
