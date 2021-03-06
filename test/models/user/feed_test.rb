require 'test_helper'

class UserTest < ActiveSupport::TestCase
  attr_reader :michael, :archer, :lana

  setup do
    @michael = users(:michael)
    @archer = users(:archer)
    @lana = users(:lana)
  end

  test "feed should have the right posts" do
    # Posts from followed user
    lana.microposts.each do |post_following|
      assert MicropostFeed.for(michael).include?(post_following)
    end
    # Posts from self
    michael.microposts.each do |post_self|
      assert MicropostFeed.for(michael).include?(post_self)
    end
    # Posts from unfollowed user
    archer.microposts.each do |post_unfollowed|
      assert_not MicropostFeed.for(michael).include?(post_unfollowed)
    end
  end
end
