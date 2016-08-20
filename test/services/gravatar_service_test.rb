require 'test_helper'

class GravatarServiceTest < ActiveSupport::TestCase
  attr_reader :email, :digest

  def setup
    @email = "user@example.com"
    @digest = "1234567890"
  end

  test ".url without size" do
    actual = -> { GravatarService.url(email) }
    expected = "https://secure.gravatar.com/avatar/#{digest}?s=80"
    Digest.stub_const :MD5, hexdigest_mock do
      assert actual, expected
    end
  end

  test ".url with size" do
    size = 100
    actual = -> { GravatarService.url(email, size: size) }
    expected = "https://secure.gravatar.com/avatar/#{digest}?s=#{size}"
    Digest.stub_const :MD5, hexdigest_mock do
      assert actual, expected
    end
  end

  private

  def hexdigest_mock
    Minitest::Mock.new.expect(:hexdigest, digest, [email])
  end
end
