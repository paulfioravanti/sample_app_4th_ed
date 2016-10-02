require 'test_helper'

class User::PasswordTest < ActiveSupport::TestCase
  attr_reader :user

  setup do
    @user = User.new(name: "Example User", email: "user@example.com")
  end

  test "password cannot be blank" do
    user.password = user.password_confirmation = " " * 6
    assert user.invalid?
  end

  test "password must be 6 characters or more" do
    user.password = user.password_confirmation = "a" * 5
    assert user.invalid?
  end
end
