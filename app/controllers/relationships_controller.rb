class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def index
    relationship_type = params[:relationship_type]
    @user = UserDecorator.decorate(
      User.find_with_relationships(params[:id], relationship_type),
      context: { page: params[:page], relationship_type: relationship_type }
    )
  end

  def create
    @user = UserDecorator.decorate(User.find(params[:followed_id]))
    current_user.follow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = UserDecorator.decorate(Relationship.find(params[:id]).followed)
    current_user.unfollow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def self.local_prefixes
    [controller_path, "users"]
  end
  private_class_method :local_prefixes
end
