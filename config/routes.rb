RegistrationApi::Application.routes.draw do
  namespace :api do
    namespace :v1 do
      devise_scope :user do
        post 'sign_up' => 'registrations#create', :as => 'register'
        post 'login' => 'sessions#create', :as => 'login'
        delete 'logout' => 'sessions#destroy', :as => 'logout'
      end
      devise_for :users, controllers: {omniauth_callbacks: "authentications"}
    end
  end
end
