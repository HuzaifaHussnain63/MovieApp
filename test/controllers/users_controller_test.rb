require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get homepage" do
    get users_homepage_url
    assert_response :success
  end

end
