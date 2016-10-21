module Password
  module Digest
    module_function

    # Returns the hash digest of the given string.
    def generate(string)
      cost =
        if ActiveModel::SecurePassword.min_cost
          BCrypt::Engine::MIN_COST
        else
          BCrypt::Engine.cost
        end
      BCrypt::Password.create(string, cost: cost)
    end

    # Returns true if the given token matches the digest.
    # aka User#authenticated?
    def matches_token?(digest, token)
      if digest.present?
        BCrypt::Password.new(digest).is_password?(token)
      else
        false
      end
    rescue BCrypt::Errors::InvalidHash
      false
    end
  end
end
