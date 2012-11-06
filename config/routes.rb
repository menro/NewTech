Newtech::Application.routes.draw do

  ActiveAdmin.routes(self)

  resource :api, :path => "api/v1", :as => "api_v1", :controller => "api", :only => [] do
    collection do
      get :companies
      get :counties
      get :county
      get :tags
      get :employees_types
      get :investments_types
      get :categories
    end
  end

  resources :companies  do
      member do
        delete "image/destroy", :as => "image_destroy", :to => "companies#destroy_image"
      end
    end

  devise_for :users, :controllers => { :registrations => :registrations }

#
  # Profile Area
  #
  get "profile/account" => "profile#account"
  put "profile/password" => "profile#password_update"
  get "profile" => "profile#show"
  put "profile/update" => "profile#update"


  root :to => 'home#welcome'

end
