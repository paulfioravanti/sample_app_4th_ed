class UserAuthenticator
  def self.authenticate(credentials)
    user = User.find_by(email: credentials[:email].downcase)
    user&.authenticate(credentials[:password])
  end
end
