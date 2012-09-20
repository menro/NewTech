Newtech::Application.routes.draw do

  scope "/api/v1", :as => "api_v1" do
    resources :counties,  :only => [:index]
    resources :offices,     :only => [:index]
  end

  resources :companies, :only => [:create, :new]  do
      member do
        get "image/:style", :as => "image", :to => "companies#send_image"
      end
    end

  devise_for :users, :controllers => { :registrations => :registrations }

  root :to => 'home#welcome'

end
