class UserDecorator < Draper::Decorator
  delegate_all

  def gravatar(size: nil)
    helpers.image_tag(
      GravatarService.url(email.downcase, size: size),
      alt: name,
      class: "gravatar"
    )
  end
end
