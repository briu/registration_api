RegistrationApi::Application.routes.draw do
  namespace :api do
    namespace :v1 do
      devise_scope :user do
        post 'sign_up' => 'registrations#create', :as => 'register'
        post 'login' => 'sessions#create', :as => 'login'
        delete 'logout' => 'sessions#destroy', :as => 'logout'
      end
      match '/invite',    to: 'invites#invite'
    end
  end
end
