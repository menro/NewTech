Newtech::Application.routes.draw do

  namespace "api" do
    scope "/v1", :as => "v1" do
      resources :offices, :only => [:index]
    end
  end

  resources :companies, :only => [:create, :new]

  devise_for :users, :controllers => { :registrations => :registrations }

  root :to => 'home#welcome'

end
