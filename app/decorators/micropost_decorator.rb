class MicropostDecorator < Draper::Decorator
  delegate_all
  decorates_association :user

  delegate :gravatar_image,
           to: :user, prefix: true

  def self.collection_decorator_class
    PaginatingDecorator
  end

  def timestamp
    helpers.time_ago_in_words(created_at)
  end
end
