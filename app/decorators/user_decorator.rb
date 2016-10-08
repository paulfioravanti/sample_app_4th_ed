class UserDecorator < Draper::Decorator
  delegate_all

  def self.collection_decorator_class
    PaginatingDecorator
  end

  def gravatar_image(size: nil)
    helpers.image_tag(
      Gravatar.url(email.downcase, size: size), alt: name, class: "gravatar"
    )
  end

  # NOTE: The `microposts` association needs to:
  # a) be decorated, but also
  # b) have a parameter passed to it so it can be paginated
  # Hence, this implementation override of the microposts method
  def microposts
    @microposts ||=
      MicropostDecorator.decorate_collection(
        object.microposts.paginate(page: context[:page])
      )
  end
end
