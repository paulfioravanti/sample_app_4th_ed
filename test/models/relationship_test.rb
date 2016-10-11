require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase
  def setup
    @relationship =
      Relationship.new(follower: users(:michael), followed: users(:archer))
  end

  test "should be valid" do
    assert @relationship.valid?
  end

  test "should require a follower" do
    @relationship.follower = nil
    assert_not @relationship.valid?
  end

  test "should require a followed" do
    @relationship.followed = nil
    assert_not @relationship.valid?
  end
end
