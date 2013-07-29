Newtech::Application.routes.draw do

  get "/sponsor_over_view" => "sponsor#sponsor_over_view", :as => "sponsor_view"
  get "/thanks" => "sponsor#thanks", :as => "thanks"

  ActiveAdmin.routes(self)

  resource :api, :path => "api/v1", :as => "api_v1", :controller => "api", :only => [] do
    collection do
      get :companies
      get :counties
      get :county
      get :tags
      get :skills
      get :employees_types
      get :investments_types
      get :categories
      get :jobs
      get :job_kinds
      get :job_roles
    end
  end

  resources :companies  do
    member do
      delete "image/destroy", :as => "image_destroy", :to => "companies#destroy_image"
    end
  end

  resources :jobs


  devise_for :users, :controllers => { :registrations => :registrations }
  devise_for :freelancers, :controllers => {:registrations => :freelancer_registrations}
  get "email_confirmation" => "home#email_confirmation", :as => "email_confirmation"

  resources :freelancer, only: [], path: 'freelancers', controller: 'freelancers' do
    collection do
      get '/:username' => "freelancers#show"
      get '/' => 'freelancers#index'
    end
  end

  # Profile Area
  get "profile/account" => "profile#account"
  put "profile/password" => "profile#password_update"
  get "profile" => "profile#show"
  put "profile/update" => "profile#update"

  get 'hiring' => 'home#jobs', as: 'hiring'
  root :to => 'home#welcome'

end
