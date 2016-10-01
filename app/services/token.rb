module Token
  def self.generate
    SecureRandom.urlsafe_base64
  end
end
