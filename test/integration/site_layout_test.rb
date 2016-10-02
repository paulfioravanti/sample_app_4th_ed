require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  setup do
    get root_path
  end

  test "layout links" do
    assert_template 'pages/home'
    assert_select "a#logo[href=?]", root_path

    assert_select "header nav" do
      assert_select "a[href=?]", root_path, count: 1
      assert_select "a[href=?]", help_path, count: 1
    end

    assert_select "footer nav" do
      assert_select "a[href=?]", about_path, count: 1
      assert_select "a[href=?]", contact_path, count: 1
    end
  end

  test "title text" do
    assert_select "title", full_title

    get contact_path
    assert_select "title", full_title("Contact")
  end
end
