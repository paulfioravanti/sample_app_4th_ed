module Gravatar
  module_function

  def url(email, size: 80)
    digest = Digest::MD5.hexdigest(email)
    "https://secure.gravatar.com/avatar/#{digest}?s=#{size}"
  end
end
