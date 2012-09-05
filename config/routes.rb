Newtech::Application.routes.draw do

  scope "/api/v1", :as => "api_v1" do
    resources :offices, :only => [:index]
  end

  resources :companies, :only => [:new]

  devise_for :users, :controllers => { :registrations => :registrations }

  root :to => 'home#welcome'

end
