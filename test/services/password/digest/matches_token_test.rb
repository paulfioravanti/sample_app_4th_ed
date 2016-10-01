require "test_helper"

class Password::Digest::MatchesTokenTest < ActiveSupport::TestCase
  attr_reader :token, :actual

  def setup
    @token = "password"
    @actual = -> { Password::Digest.matches_token?(digest, token) }
  end

  class DigestIsPasswordTest < Password::Digest::MatchesTokenTest
    attr_reader :digest

    def setup
      super
      @digest = "$2a$10$s0NLf4rIfAOE8HAl9pVYG.sza43aSstcjiIUur6Xjslw/k.KGYmbK"
    end

    test ".matches_token?" do
      expected = true
      assert_equal expected, actual.call
    end
  end

  class DigestIsNotPasswordTest < Password::Digest::MatchesTokenTest
    attr_reader :digest

    def setup
      super
      @digest = "$2a$10$N3NMcb7r9oYQKZtlA7KkEu2YTks0M33lLlz0DrxuOIkmbk9Mi2C8W"
    end

    test ".matches_token?" do
      expected = false
      assert_equal expected, actual.call
    end
  end

  class DigestBlankTest < Password::Digest::MatchesTokenTest
    attr_reader :digest

    def setup
      super
      @digest = nil
    end

    test ".matches_token?" do
      expected = false
      assert_equal expected, actual.call
    end
  end
end
