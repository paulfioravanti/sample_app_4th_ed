require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest
  attr_reader :user

  setup do
    @user = users(:michael)
  end

  class ValidLoginTest < UsersLoginTest
    test "login with valid information followed by logout" do
      get login_path
      post login_path,
           params: { session: { email: user.email, password: 'password' } }
      assert logged_in_user?
      assert_redirected_to user

      follow_redirect!
      assert_template 'users/show'
      assert_select "a[href=?]", login_path, count: 0
      assert_select "a[href=?]", logout_path
      assert_select "a[href=?]", user_path(user)

      delete logout_path
      assert_not logged_in_user?
      assert_redirected_to root_url

      # Simulate a user clicking logout in a second window.
      delete logout_path

      follow_redirect!
      assert_select "a[href=?]", login_path
      assert_select "a[href=?]", logout_path, count: 0
      assert_select "a[href=?]", user_path(user), count: 0
    end
  end

  class InvalidLoginTest < UsersLoginTest
    test "login with invalid information" do
      get login_path
      assert_template "sessions/new"

      post login_path, params: { session: { email: "", password: "" } }
      assert_template "sessions/new"
      assert_not flash.empty?

      get root_path
      assert flash.empty?
    end
  end

  class LoginWithRememberTest < UsersLoginTest
    test "login with remembering" do
      log_in_as(user, remember_me: '1')
      assert_not_nil cookies['remember_token']
    end
  end

  class LoginWithoutRememberTest < UsersLoginTest
    test "login without remembering" do
      log_in_as(user, remember_me: '0')
      assert_nil cookies['remember_token']
    end
  end
end
