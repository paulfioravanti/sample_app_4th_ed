module MicropostFeed
  module_function

  def for(user)
    microposts_by(followed_user_ids_for(user)).or(microposts_by(user))
  end

  def followed_user_ids_for(user)
    Relationship.where(follower: user).pluck(:followed_id)
  end
  private_class_method

  def microposts_by(users)
    Micropost.includes(:user).where(user: users)
  end
  private_class_method :microposts_by
end
