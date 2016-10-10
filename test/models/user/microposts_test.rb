require 'test_helper'

class User::MicropostsTest < ActiveSupport::TestCase
  attr_reader :user

  setup do
    @user = User.create(
      name: "Example User",
      email: "user@example.com",
      password: "foobar",
      password_confirmation: "foobar"
    )
    user.microposts.create!(content: "Lorem ipsum")
  end

  test "associated microposts should be destroyed" do
    assert_difference "Micropost.count", -1 do
      user.destroy
    end
  end
end
