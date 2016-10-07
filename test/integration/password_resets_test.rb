require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest
  attr_reader :user

  setup do
    ActionMailer::Base.deliveries.clear
    @user = users(:michael)
  end

  class NewPasswordResetTest < self
    setup do
      get new_password_reset_path
      assert_template 'password_resets/new'
    end

    class InvalidEmailTest < self
      setup do
        post password_resets_path, params: { password_reset: { email: "" } }
      end

      test "shows an error and re-renders the password reset page" do
        assert_not flash.empty?
        assert_template 'password_resets/new'
      end
    end

    class ValidEmailTest < self
      setup do
        post password_resets_path,
             params: { password_reset: { email: user.email } }
      end

      test "sends a password reset email to the user" do
        assert_not_equal user.reset_digest, user.reload.reset_digest
        assert_equal 1, ActionMailer::Base.deliveries.size
        assert_not flash.empty?
        assert_redirected_to root_url
      end
    end
  end

  class EditPasswordResetTest < self
    setup do
      post password_resets_path,
           params: { password_reset: { email: user.email } }
      @user = assigns(:user)
    end

    class WrongEmailTest < self
      setup do
        get edit_password_reset_path(user.reset_token, email: "")
      end

      test "password reset fails and user is redirected to the root url" do
        assert_redirected_to root_url
      end
    end

    class InactiveUserTest < self
      setup do
        @user.update_attributes(activated: false, activated_at: nil)
        get edit_password_reset_path(user.reset_token, email: user.email)
      end

      test "password reset fails and user is redirected to the root url" do
        assert_redirected_to root_url
      end
    end

    class RightEmailWrongTokenTest < self
      setup do
        get edit_password_reset_path('wrong token', email: user.email)
      end

      test "password reset fails and user is redirected to the root url" do
        assert_redirected_to root_url
      end
    end

    class RightEmailRightTokenTest < self
      setup do
        get edit_password_reset_path(user.reset_token, email: user.email)
      end

      test "renders the password edit page" do
        assert_template 'password_resets/edit'
        assert_select "input[name=email][type=hidden][value=?]", user.email
      end
    end

    class InvalidPasswordAndConfirmationTest < self
      setup do
        patch password_reset_path(user.reset_token),
              params: { email: user.email,
                        user: { password: "foobaz",
                                password_confirmation: "barquux" } }
      end

      test "displays an error" do
        assert_select 'div.error-explanation'
      end
    end

    class EmptyPasswordAndConfirmationTest < self
      setup do
        patch password_reset_path(user.reset_token),
              params: { email: user.email,
                        user: { password:              "",
                                password_confirmation: "" } }
      end

      test "displays an error" do
        assert_select 'div.error-explanation'
      end
    end

    class ValidPasswordAndConfirmationTest < self
      setup do
        patch password_reset_path(user.reset_token),
              params: { email: user.email,
                        user: { password:              "foobaz",
                                password_confirmation: "foobaz" } }
      end

      test "logs in the user and redirects to their profile page" do
        assert logged_in_user?
        assert_not flash.empty?
        assert_redirected_to user
      end
    end

    class ExpiredTokenTest < self
      setup do
        @user.update_attribute(:reset_sent_at, 3.hours.ago)
        patch password_reset_path(user.reset_token),
              params: { email: user.email,
                        user: { password:              "foobaz",
                                password_confirmation: "foobaz" } }
      end

      test "displays an error and redirects" do
        assert_response :redirect
        follow_redirect!
        assert_match(/Password reset has expired/i, response.body)
      end
    end
  end
end
