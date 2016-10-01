require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  def setup
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

    test "valid signup information" do
      assert_difference 'User.count', 1 do
        post(users_path, params: params)
      end

      follow_redirect!
      # assert_template 'users/show'
      # assert flash[:success]
      # assert logged_in_user?
    end
  end
end
