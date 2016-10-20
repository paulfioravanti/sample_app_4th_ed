require 'test_helper'

class Micropost::ContentTest < ActiveSupport::TestCase
  attr_reader :micropost

  setup do
    @micropost = Micropost.new(user: users(:michael))
  end

  test "content is a non-empty string of characters" do
    micropost.content = "This is some content"
    assert micropost.valid?
  end

  test "content must be present" do
    micropost.content = "   "
    assert_not micropost.valid?
  end

  test "content must be at most 140 characters" do
    micropost.content = "a" * 141
    assert_not micropost.valid?
  end
end
