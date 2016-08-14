require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "layout links" do
    get root_path
    assert_template 'pages/home'
    assert_select "a#logo[href=?]", root_path
    assert_select "header nav" do
      assert_select "a[href=?]", root_path
      assert_select "a[href=?]", help_path
    end
    assert_select "footer nav" do
      assert_select "a[href=?]", about_path
      assert_select "a[href=?]", contact_path
    end
  end
end
