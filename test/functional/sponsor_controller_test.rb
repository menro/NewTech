require 'test_helper'

class SponsorControllerTest < ActionController::TestCase
  test "should get sponsor_view" do
    get :sponsor_over_view
    assert_response :success
  end
  
  test "should get sponsor thanks" do
    get :thanks
    assert_response :success
  end
  
  # No routes for these tests:
  
  # test "should get index" do
  #   get :index
  #   assert_response :success
  # end
  # 
  # test "should get new" do
  #   get :new
  #   assert_response :success
  # end
  # 
  # test "should get create" do
  #   get :create
  #   assert_response :success
  # end
  # 
  # test "should get update" do
  #   get :update
  #   assert_response :success
  # end
  # 
  # test "should get delete" do
  #   get :delete
  #   assert_response :success
  # end

end
