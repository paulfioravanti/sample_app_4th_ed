require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  attr_reader :user

  setup do
    @user = users(:michael)
  end

  class UnsuccessfulEditTest < self
    setup do
      log_in_as(user)
      get edit_user_path(user)
    end

    test "unsuccessful edit" do
      assert_template 'users/edit'

      patch(user_path(user), params: {
        user: {
          name:  "",
          email: "foo@invalid",
          password: "foo",
          password_confirmation: "bar"
        }
      })
      assert_template 'users/edit'
    end
  end

  class SuccessfulEditTest < self
    # NOTE: Cannot use `attr_reader :name`
    attr_reader :user_name, :email

    setup do
      @user_name = "Foo Bar"
      @email = "foo@bar.com"
      get edit_user_path(user)
      log_in_as(user)
      assert_redirected_to edit_user_path(user)
    end

    test "successful edit" do
      patch(user_path(user), params: {
        user: {
          name: user_name,
          email: email,
          password: "",
          password_confirmation: ""
        }
      })

      assert_not flash.empty?
      assert_redirected_to user

      user.reload
      assert_equal user_name, user.name
      assert_equal email, user.email
    end
  end
end
