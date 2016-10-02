require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  attr_reader :string

  setup do
    @string = "Help"
  end

  test "#full_title" do
    assert_equal full_title, "Ruby on Rails Tutorial Sample App"
    assert_equal(
      full_title(string),
      "#{string} | Ruby on Rails Tutorial Sample App"
    )
  end
end
