require 'test_helper'

class Micropost::OrderTest < ActiveSupport::TestCase
  test "order should be most recent first" do
    assert_equal microposts(:most_recent), Micropost.most_recent.first
  end
end
