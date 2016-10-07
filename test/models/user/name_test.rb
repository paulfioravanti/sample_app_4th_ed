require 'test_helper'

class User::NameTest < ActiveSupport::TestCase
  attr_reader :user

  setup do
    @user = User.new(
      email: "user@example.com",
      password: "foobar",
      password_confirmation: "foobar"
    )
  end

  test "name cannot be blank" do
    user.name = "     "
    assert user.invalid?
  end

  test "name has a maximum of 50 characters" do
    user.name = "a" * 51
    assert user.invalid?
  end
end
