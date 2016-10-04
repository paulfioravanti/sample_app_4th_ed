require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest
  attr_reader :user

  setup do
    ActionMailer::Base.deliveries.clear
    @user = users(:michael)
  end

  class InvalidEmailTest < self
    setup do
      get new_password_reset_path
      assert_template 'password_resets/new'
    end

    test "shows an error and re-renders the password reset page" do
      post password_resets_path, params: { password_reset: { email: "" } }
      assert_not flash.empty?
      assert_template 'password_resets/new'
    end
  end

  class ValidEmailTest < self
    setup do
      get new_password_reset_path
      assert_template 'password_resets/new'
    end

    test "sends a password reset email to the user" do
      post password_resets_path,
           params: { password_reset: { email: user.email } }
      assert_not_equal user.reset_digest, user.reload.reset_digest
      assert_equal 1, ActionMailer::Base.deliveries.size
      assert_not flash.empty?
      assert_redirected_to root_url
    end
  end

  class WrongEmailTest < self
    setup do
      post password_resets_path,
           params: { password_reset: { email: user.email } }
      @user = assigns(:user)
    end

    test "password reset fails and user is redirected to the root url" do
      get edit_password_reset_path(user.reset_token, email: "")
      assert_redirected_to root_url
    end
  end

  class InactiveUserTest < self
    setup do
      post password_resets_path,
           params: { password_reset: { email: user.email } }
      @user = assigns(:user)
      @user.update_attributes(activated: false, activated_at: nil)
    end

    test "password reset fails and user is redirected to the root url" do
      get edit_password_reset_path(user.reset_token, email: user.email)
      assert_redirected_to root_url
    end
  end

  class RightEmailWrongTokenTest < self
    setup do
      post password_resets_path,
           params: { password_reset: { email: user.email } }
      @user = assigns(:user)
    end

    test "password reset fails and user is redirected to the root url" do
      get edit_password_reset_path('wrong token', email: user.email)
      assert_redirected_to root_url
    end
  end

  class RightEmailRightTokenTest < self
    setup do
      post password_resets_path,
           params: { password_reset: { email: user.email } }
      @user = assigns(:user)
    end

    test "renders the password edit page" do
      get edit_password_reset_path(user.reset_token, email: user.email)
      assert_template 'password_resets/edit'
      assert_select "input[name=email][type=hidden][value=?]", user.email
    end
  end

  class InvalidPasswordAndConfirmationTest < self
    setup do
      post password_resets_path,
           params: { password_reset: { email: user.email } }
      @user = assigns(:user)
    end

    test "displays an error" do
      patch password_reset_path(user.reset_token),
            params: { email: user.email,
                      user: { password:              "foobaz",
                              password_confirmation: "barquux" } }
      assert_select 'div.error-explanation'
    end
  end

  class EmptyPasswordAndConfirmationTest < self
    setup do
      post password_resets_path,
           params: { password_reset: { email: user.email } }
      @user = assigns(:user)
    end

    test "displays an error" do
      patch password_reset_path(user.reset_token),
            params: { email: user.email,
                      user: { password:              "",
                              password_confirmation: "" } }
      assert_select 'div.error-explanation'
    end
  end

  class ValidPasswordAndConfirmationTest < self
    setup do
      post password_resets_path,
           params: { password_reset: { email: user.email } }
      @user = assigns(:user)
    end

    test "displays an error" do
      patch password_reset_path(user.reset_token),
            params: { email: user.email,
                      user: { password:              "foobaz",
                              password_confirmation: "foobaz" } }
      assert logged_in_user?
      assert_not flash.empty?
      assert_redirected_to user
    end
  end
end
