require 'test_helper'

class FollowingTest < ActionDispatch::IntegrationTest
  attr_reader :user, :other

  setup do
    @user = users(:michael)
    @other = users(:archer)
    log_in_as(user)
  end

  class FollowingPageTest < self
    setup do
      get following_user_path(@user)
    end

    test "following page" do
      assert_not user.following.empty?
      assert_match user.following.count.to_s, response.body
      user.following.each do |followed_user|
        assert_select "a[href=?]", user_path(followed_user)
      end
    end
  end

  class FollowingUserTest < self
    attr_reader :params

    setup do
      @params = { followed_id: other.id }
    end

    test "following a user the standard way" do
      assert_difference "user.following.count", 1 do
        post relationships_path, params: params
      end
    end

    test "following a user with Ajax" do
      assert_difference "user.following.count", 1 do
        post relationships_path, xhr: true, params: params
      end
    end
  end

  class FollowersPageTest < self
    setup do
      get followers_user_path(user)
    end

    test "followers page" do
      assert_not user.followers.empty?
      assert_match user.followers.count.to_s, response.body
      user.followers.each do |following_user|
        assert_select "a[href=?]", user_path(following_user)
      end
    end
  end

  class UnfollowingUserTest < self
    attr_reader :relationship

    setup do
      user.follow(other)
      @relationship = user.active_relationships.find_by(followed_id: other.id)
    end

    test "unfollowing a user the standard way" do
      assert_difference 'user.following.count', -1 do
        delete relationship_path(relationship)
      end
    end

    test "unfollowing a user with Ajax" do
      assert_difference 'user.following.count', -1 do
        delete relationship_path(relationship), xhr: true
      end
    end
  end
end
