require 'test_helper'

class User::EmailTest < ActiveSupport::TestCase
  attr_reader :user

  def setup
    @user = User.new(
      name: "Example User",
      password: "foobar",
      password_confirmation: "foobar"
    )
  end

  test "email cannot be blank" do
    user.email = "     "
    assert user.invalid?
  end

  test "email must be 255 characters or less" do
    user.email = "#{'a' * 244}@example.com"
    assert user.invalid?
  end

  test "email validation accepts valid addresses" do
    valid_addresses.each do |valid_address|
      user.email = valid_address
      assert user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation rejects invalid addresses" do
    invalid_addresses.each do |invalid_address|
      user.email = invalid_address
      assert(
        user.invalid?,
        "#{invalid_address.inspect} should be invalid"
      )
    end
  end

  test "email addresses must be unique" do
    user.email = "user@example.com"
    create_duplicate_user
    assert user.invalid?
  end

  test "email addresses is saved as lowercase" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    user.email = mixed_case_email
    user.save
    assert_equal mixed_case_email.downcase, user.reload.email
  end

  private

  def valid_addresses
    %w[
      user@example.com USER@foo.COM A_US-ER@foo.bar.org
      first.last@foo.jp alice+bob@baz.cn
    ]
  end

  def invalid_addresses
    %w[
      user@example,com user_at_foo.org user.name@example.
      foo@bar_baz.com foo@bar+baz.com
    ]
  end

  def create_duplicate_user
    duplicate_user = user.dup
    duplicate_user.email.upcase!
    duplicate_user.save
  end
end
