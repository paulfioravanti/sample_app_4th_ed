require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
    get signup_path
  end

  class InvalidSignup < self
    attr_reader :params

    def setup
      super
      @params = {
        user: {
          name:  "",
          email: "user@invalid",
          password: "foo",
          password_confirmation: "bar"
        }
      }
    end

    test "invalid signup information" do
      assert_no_difference 'User.count' do
        post(users_path, params: params)
      end
      assert_template 'users/new'
      assert_select 'div.error-explanation'
      assert_select 'div.field-with-errors'
      assert_not flash[:success]
    end
  end

  class ValidSignup < self
    attr_reader :params

    def setup
      super
      @params = {
        user: {
          name:  "Example User",
          email: "user@example.com",
          password: "password",
          password_confirmation: "password"
        }
      }
    end

    test "valid signup information with account activation" do
      assert_difference 'User.count', 1 do
        post(users_path, params: params)
      end
      assert_equal 1, ActionMailer::Base.deliveries.size
      user = assigns(:user)
      assert_not user.activated?
      # Try to log in before activation.
      log_in_as(user)
      assert_not logged_in_user?
      # Invalid activation token
      get edit_account_activation_path("invalid token", email: user.email)
      assert_not logged_in_user?
      # Valid token, wrong email
      get edit_account_activation_path(user.activation_token, email: 'wrong')
      assert_not logged_in_user?
      # Valid activation token
      get edit_account_activation_path(user.activation_token, email: user.email)
      assert user.reload.activated?
      follow_redirect!
      assert_template 'users/show'
      assert logged_in_user?
    end
  end
end
