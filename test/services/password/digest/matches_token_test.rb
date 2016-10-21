require "test_helper"

class Password::Digest::MatchesTokenTest < ActiveSupport::TestCase
  attr_reader :token, :digest, :actual

  setup do
    @token = "password"
    @actual = -> { Password::Digest.matches_token?(digest, token) }
  end

  class DigestIsPasswordTest < self
    setup do
      @digest = "$2a$10$s0NLf4rIfAOE8HAl9pVYG.sza43aSstcjiIUur6Xjslw/k.KGYmbK"
    end

    test "returns true" do
      assert_equal true, actual.call
    end
  end

  class DigestIsNotPasswordTest < self
    setup do
      @digest = "$2a$10$N3NMcb7r9oYQKZtlA7KkEu2YTks0M33lLlz0DrxuOIkmbk9Mi2C8W"
    end

    test "returns false" do
      assert_equal false, actual.call
    end
  end

  class DigestIsBlankTest < self
    setup do
      @digest = ""
    end

    test "returns false" do
      assert_equal false, actual.call
    end
  end

  class DigestIsInvalidHashTest < self
    setup do
      @digest = "invalid"
    end

    test "returns false" do
      assert_equal false, actual.call
    end
  end
end
