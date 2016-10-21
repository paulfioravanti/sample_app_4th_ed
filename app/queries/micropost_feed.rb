module MicropostFeed
  module_function

  def for(user)
    microposts_by(followed_users_for(user)).or(microposts_by(user))
  end

  def followed_users_for(user)
    Relationship.where(follower: user).pluck(:followed_id)
  end
  private_class_method :followed_users_for

  def microposts_by(users)
    Micropost.includes(:user).where(user: users)
  end
  private_class_method :microposts_by
end
