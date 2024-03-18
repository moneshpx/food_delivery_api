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
  put '/password_resets', to: 'forgot_passwords#update'
  post '/food_create', to: 'foods#create'
  get '/food_list', to: 'foods#food_list'
  resources :foods
end
