class GravatarService
  def self.url(email, size: 80)
    id = Digest::MD5::hexdigest(email)
    "https://secure.gravatar.com/avatar/#{id}?s=#{size}"
  end
end
