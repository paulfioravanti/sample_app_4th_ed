require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  attr_reader :base_title

  def setup
    @base_title = "Ruby on Rails Tutorial Sample App"
  end

  test "get home succeeds" do
    get root_path
    assert_response :success
    assert_select "title", base_title
  end

  test "get help succeeds" do
    get help_path
    assert_response :success
    assert_select "title", "Help | #{base_title}"
  end

  test "get about succeeds" do
    get about_path
    assert_response :success
    assert_select "title", "About | #{base_title}"
  end

  test "get contact succeeds" do
    get contact_path
    assert_response :success
    assert_select "title", "Contact | #{base_title}"
  end
end
