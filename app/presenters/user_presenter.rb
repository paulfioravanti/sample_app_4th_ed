class UserPresenter
  attr_reader :user, :page

  delegate :name, :gravatar_image, :microposts,
           to: :user

  def initialize(user:, page:)
    @user = user
    @page = page
  end

  def paginated_microposts
    @paginated_microposts ||= MicropostDecorator.decorate_collection(
      user.microposts.paginate(page: page)
    )
  end
end
