require 'test_helper'

class GravatarTest < ActiveSupport::TestCase
  attr_reader :email, :digest, :hexdigest_mock

  def setup
    @email = "user@example.com"
    @digest = "1234567890"
    @hexdigest_mock =
      Minitest::Mock.new.expect(:call, digest, [email])
  end

  test ".url without size" do
    expected = "https://secure.gravatar.com/avatar/#{digest}?s=80"
    actual = -> { Gravatar.url(email) }
    Digest::MD5.stub :hexdigest, hexdigest_mock do
      assert_equal expected, actual.call
    end
  end

  test ".url with size" do
    size = 100
    expected = "https://secure.gravatar.com/avatar/#{digest}?s=#{size}"
    actual = -> { Gravatar.url(email, size: size) }
    Digest::MD5.stub :hexdigest, hexdigest_mock do
      assert_equal expected, actual.call
    end
  end
end
