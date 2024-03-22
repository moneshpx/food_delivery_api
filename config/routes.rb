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

  ###########Restaurant###########
  post '/create_restaurant', to: "restaurants#create_restaurant"
 
  ###########Item routes ###########
  post '/item_create', to: 'items#item_create'
  patch '/item_update', to: 'items#item_update'
  get '/item_list',to: "items#item_list"
  get '/item_details', to: "items#item_details"

end
