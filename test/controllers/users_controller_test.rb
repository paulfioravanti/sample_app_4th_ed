require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  attr_reader :user, :other_user

  setup do
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test "get new succeeds" do
    get signup_path
    assert_response :success
  end

  class NotLoggedInTest < self
    test "redirects index" do
      get users_path
      assert_redirected_to login_url
    end

    test "redirects edit" do
      get edit_user_path(user)
      assert_not flash.empty?
      assert_redirected_to login_url
    end

    test "redirects update" do
      patch(user_path(user), params: {
        user: {
          name: user.name,
          email: user.email
        }
      })
      assert_not flash.empty?
      assert_redirected_to login_url
    end

    test "redirects following" do
      get following_user_path(user)
      assert_redirected_to login_url
    end

    test "redirects followers" do
      get followers_user_path(user)
      assert_redirected_to login_url
    end

    test "redirects destroy" do
      assert_no_difference 'User.count' do
        delete user_path(user)
      end
      assert_redirected_to login_url
    end
  end

  class LoggedInAsWrongUserTest < self
    setup do
      log_in_as(other_user)
    end

    test "should redirect edit when logged in as wrong user" do
      get edit_user_path(user)
      assert flash.empty?
      assert_redirected_to root_url
    end

    test "should redirect update when logged in as wrong user" do
      patch(user_path(user), params: {
        user: {
          name: user.name,
          email: user.email
        }
      })
      assert flash.empty?
      assert_redirected_to root_url
    end
  end

  class LoggedInAsNonAdminTest < self
    setup do
      log_in_as(other_user)
    end

    test "should redirect destroy when logged in as a non-admin" do
      assert_no_difference 'User.count' do
        delete user_path(user)
      end
      assert_redirected_to root_url
    end

    test "should not allow the admin attribute to be edited via the web" do
      assert_not other_user.admin?
      patch(user_path(other_user), params: {
        user: {
          password: other_user.password,
          password_confirmation: other_user.password,
          admin: true
        }
      })
      assert_not other_user.admin?
    end
  end
end
