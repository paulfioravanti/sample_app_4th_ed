module Token
  def generate
    SecureRandom.urlsafe_base64
  end
end
