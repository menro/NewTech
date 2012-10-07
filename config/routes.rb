Newtech::Application.routes.draw do

  ActiveAdmin.routes(self)

  resource :api, :path => "api/v1", :as => "api_v1", :controller => "api", :only => [] do
    collection do
      get :companies
      get :counties
      get :tags
    end
  end

  resources :companies  do
      member do
        get "image/:style", :as => "image", :to => "companies#send_image"
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
