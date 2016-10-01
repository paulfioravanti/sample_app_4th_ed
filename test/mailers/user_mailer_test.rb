require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  attr_reader :user

  setup do
    @user = users(:michael)
    user.activation_token = Token.generate
  end

  test "#account_activation" do
    mail = UserMailer.account_activation(user)
    assert_equal "Account activation", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match user.name,               mail.body.encoded
    assert_match user.activation_token,   mail.body.encoded
    assert_match CGI.escape(user.email),  mail.body.encoded
  end
end