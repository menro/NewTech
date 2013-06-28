require 'test_helper'

class ProfileControllerTest < ActionController::TestCase
  test "should get show" do
    setup_users
    sign_in @authorized_user
    get :show
    assert_response :success
  end

end
