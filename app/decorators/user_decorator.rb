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

  def paginated_microposts
    @paginated_microposts ||= MicropostDecorator.decorate_collection(
      microposts.paginate(page: context[:page])
    )
  end
end
