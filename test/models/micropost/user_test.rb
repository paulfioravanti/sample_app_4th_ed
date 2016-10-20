require 'test_helper'

class Micropost::UserTest < ActiveSupport::TestCase
  attr_reader :micropost

  setup do
    @micropost = Micropost.new(content: "Lorem ipsum")
  end

  test "user must be present" do
    assert_not micropost.valid?
  end
end
