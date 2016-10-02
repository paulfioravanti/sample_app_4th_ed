require 'test_helper'

class User::ValidityTest < ActiveSupport::TestCase
  attr_reader :user

  setup do
    @user = User.new(
      name: "Example User",
      email: "user@example.com",
      password: "foobar",
      password_confirmation: "foobar"
    )
  end

  test "user is valid" do
    assert user.valid?
  end
end
