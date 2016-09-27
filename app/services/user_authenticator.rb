module UserAuthenticator
  def self.authenticate(credentials)
    user = User.find_by(email: credentials[:email].downcase)
    user&.authenticate(credentials[:password])
  end

  # Remembers a user in the database for use in persistent sessions.
  def self.remember(user)
    user.remember_token = Token.generate
    user.update_attribute(
      :remember_digest,
      Digest.generate(user.remember_token)
    )
  end

  # Forgets a user.
  def self.forget(user)
    user.update_attribute(:remember_digest, nil)
  end

  # Returns true if the given token matches the digest.
  def self.authenticated?(remember_digest, remember_token)
    if remember_digest.present?
      BCrypt::Password.new(remember_digest).is_password?(remember_token)
    else
      false
    end
  end
end
