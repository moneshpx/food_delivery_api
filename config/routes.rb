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
end
