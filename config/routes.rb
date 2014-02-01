Newtech::Application.routes.draw do

  get "/sponsor_over_view" => "sponsor#sponsor_over_view", :as => "sponsor_view"
  get "/thanks" => "sponsor#thanks", :as => "thanks"

  ActiveAdmin.routes(self)

  resource :api, :path => "api/v1", :as => "api_v1", :controller => "api", :only => [] do
    collection do
      get :companies
      get :counties
      get :states
      get :countries
      get :zipcodes
      get :county
      get :zipcode
      get :tags
      get :skills
      get :employees_types
      get :investments_types
      get :categories
      get :jobs
      get :job_kinds
      get :job_roles
      get :bottom_lists
      get :recent_updates
    end
  end

  resources :companies  do
    member do
      delete "image/destroy", :as => "image_destroy", :to => "companies#destroy_image"
    end
  end

  resources :jobs

  devise_for :users, :controllers => { :registrations => :registrations, sessions: :sessions }
  get "email_confirmation" => "home#email_confirmation", :as => "email_confirmation"
  

  resources :users, only: [], path: 'freelancers', controller: 'users' do
    collection do
      get '/:username' => "users#show", as: 'show_freelancer'
      get '/:username/edit' => 'users#edit_profile', as: 'edit_profile'
      get '/' => 'users#index'
      put '/:username' => 'users#update', as: 'update'
      post '/change_status' => 'users#change_status'
      put '/endorse/skill' => 'users#endorse', as: 'endorse_skill'
      put '/add/user_link' => 'users#add_user_link', as: 'add_user_link'
      delete '/remove/user_link' => 'users#remove_user_link', as: 'remove_user_link'
      get '/fetch/more' => 'users#fetch_more'
      delete '/remove/recommendation' => 'users#remove_recommendation', as: 'remove_recommendation'
    end
  end
  
  # Profile Area
  get "profile/account" => "profile#account"
  put "profile/password" => "profile#password_update"
  get "profile" => "profile#show"
  put "profile/update" => "profile#update"
  get 'update_county' => 'profile#update_county'

  get 'hiring' => 'home#jobs', as: 'hiring'
  get '/get_cities' => 'states#get_cities'

  root :to => 'home#welcome'

end
