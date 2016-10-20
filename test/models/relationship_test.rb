require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase
  attr_reader :relationship

  def setup
    @relationship =
      Relationship.new(follower: users(:michael), followed: users(:archer))
  end

  test "relationship is valid" do
    assert relationship.valid?
  end

  test "relationships requires a follower" do
    relationship.follower = nil
    assert_not relationship.valid?
  end

  test "relationships requires a followed user" do
    relationship.followed = nil
    assert_not relationship.valid?
  end
end
