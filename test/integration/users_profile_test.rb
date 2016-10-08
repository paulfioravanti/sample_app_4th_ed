require "test_helper"

class UsersProfileTest < ActionDispatch::IntegrationTest
  attr_reader :user

  def setup
    @user = users(:michael)
    get user_path(user)
  end

  test "profile display" do
    assert_template "users/show"
    assert_select "title", full_title(user.name)
    assert_select "h1", text: user.name
    assert_select "h1>img.gravatar"
    assert_match user.microposts.count.to_s, response.body
    assert_select "div.pagination"
    user.microposts.paginate(page: 1).each do |micropost|
      assert_match micropost.content, response.body
    end
  end
end
