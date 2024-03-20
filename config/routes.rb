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
  delete '/logout', to: 'users/sessions#destroy', as: :logout
  post '/forgot_password', to: 'forgot_passwords#forgot_password'
  post '/verify_code', to: 'forgot_passwords#verify_code'
  post '/food_create', to: 'foods#create'
  put '/password_resets', to: 'forgot_passwords#update'
  get '/food_list', to: 'foods#food_list'
  get '/food_details', to: 'foods#food_details'
  get '/profile_info', to: 'profiles#profile_info'
  patch '/update_profile', to: 'profiles#update_profile'
  post '/new_address', to: 'addresses#new_address'
  get '/my_address', to: 'addresses#my_address'
  patch '/update_address/:id', to: 'addresses#update_address'
end
