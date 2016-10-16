module Token
  module_function

  def generate
    SecureRandom.urlsafe_base64
  end
end
