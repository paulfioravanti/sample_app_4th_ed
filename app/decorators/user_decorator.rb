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
  def paginated_microposts
    @paginated_microposts ||=
      MicropostDecorator.decorate_collection(
        microposts.paginate(page: context[:page])
      )
  end

  def paginated_relationships
    @paginated_relationships ||=
      UserDecorator.decorate_collection(
        relationships_of_current_type.paginate(page: context[:page])
      )

  end

  def relationships
    @relationships ||=
      UserDecorator.decorate_collection(relationships_of_current_type)
  end

  def relationship_name
    @relationship_name ||= context[:relationship_type].titleize
  end

  def micropost_count
    helpers.pluralize(microposts.count, "micropost")
  end

  private

  def relationships_of_current_type
    model.public_send(context[:relationship_type])
  end
end
