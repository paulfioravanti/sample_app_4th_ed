require 'test_helper'

class GravatarTest < ActiveSupport::TestCase
  attr_reader :email, :digest, :hexdigest_mock, :expected, :actual

  setup do
    @email = "user@example.com"
    @digest = "1234567890"
    @hexdigest_mock =
      Minitest::Mock.new.expect(:call, digest, [email])
  end

  class GravatarWithoutSizeTest < GravatarTest
    setup do
      @expected = "https://secure.gravatar.com/avatar/#{digest}?s=80"
      @actual = -> { Gravatar.url(email) }
    end

    test "gravatar link size is 80" do
      Digest::MD5.stub(:hexdigest, hexdigest_mock) do
        assert_equal expected, actual.call
      end
    end
  end

  class GravatarWithSizeTest < GravatarTest
    attr_reader :size

    setup do
      @size = 100
      @expected = "https://secure.gravatar.com/avatar/#{digest}?s=#{size}"
      @actual = -> { Gravatar.url(email, size: size) }
    end

    test "gravatar url includes given size" do
      Digest::MD5.stub(:hexdigest, hexdigest_mock) do
        assert_equal expected, actual.call
      end
    end
  end
end
