ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionController::TestCase
  include Devise::TestHelpers
  
  def setup_users
    User.destroy_all
    @authorized_user = User.create(username: 'authorized', email: 'authorized@example.com', password: 'password', password_confirmation: 'password')
    @authorized_user.skip_confirmation!
    @authorized_user.save!
    # TODO: Set authorization roles for authorized user.
    
    @unauthorized_user = User.create(username: 'unauthorized', email: 'unauthorized@example.com', password: 'password', password_confirmation: 'password')
    @unauthorized_user.skip_confirmation!
    @unauthorized_user.save!
  end # def
end # class
