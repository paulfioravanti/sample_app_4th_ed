require 'test_helper'

class User::FollowTest < ActiveSupport::TestCase
  attr_reader :michael, :archer

  setup do
    @michael = users(:michael)
    @archer = users(:archer)
  end

  test "user can follow and unfollow another user" do
    assert_not michael.following?(archer)
    michael.follow(archer)
    assert michael.following?(archer)
    michael.unfollow(archer)
    assert_not michael.following?(archer)
  end
end
