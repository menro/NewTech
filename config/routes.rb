Newtech::Application.routes.draw do

  scope "/api/v1", :as => "api_v1" do
    resources :categories,  :only => [:index]
    resources :offices,     :only => [:index]
  end

  resources :categories, :only => [] do
    member do
      get "image/:style", :as => "image", :to => "categories#send_category_image"
    end
  end

  resources :companies, :only => [:create, :new]

  devise_for :users, :controllers => { :registrations => :registrations }

  root :to => 'home#welcome'

end
