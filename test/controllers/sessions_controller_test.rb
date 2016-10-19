require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "get new is successful" do
    get login_path
    assert_response :success
  end
end
