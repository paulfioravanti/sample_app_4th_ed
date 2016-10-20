require 'test_helper'

class Micropost::ValidityTest < ActiveSupport::TestCase
  attr_reader :micropost

  setup do
    @micropost = Micropost.new(content: "Lorem ipsum", user: users(:michael))
  end

  test "micropost is valid" do
    assert micropost.valid?
  end
end
