require "test_helper"

class Password::Digest::GenerateTest < ActiveSupport::TestCase
  attr_reader :string, :actual

  setup do
    @string = "some string"
    @actual = -> { Password::Digest.generate(string) }
  end

  class MinCostTest < self
    attr_reader :password_mock

    setup do
      @password_mock =
        Minitest::Mock.new.expect(
          :call,
          :password, # represents the generated BCrypt password
          [string, { cost: BCrypt::Engine::MIN_COST }]
        )
    end

    test "generating a password with min cost" do
      ActiveModel::SecurePassword.stub(:min_cost, true) do
        BCrypt::Password.stub(:create, password_mock) do
          actual.call
        end
      end
      password_mock.verify
    end
  end

  class NoMinCostTest < self
    attr_reader :password_mock

    setup do
      @password_mock =
        Minitest::Mock.new.expect(
          :call,
          :password, # represents the generated BCrypt password
          [string, { cost: BCrypt::Engine.cost }]
        )
    end

    test "generating a password with min cost" do
      ActiveModel::SecurePassword.stub(:min_cost, false) do
        BCrypt::Password.stub(:create, password_mock) do
          actual.call
        end
      end
      password_mock.verify
    end
  end
end
