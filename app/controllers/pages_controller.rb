class PagesController < ApplicationController
  before_action :set_micropost

  def show
    render params[:id]
  end

  private

  def set_micropost
   if params[:id] == "home" && logged_in?
     @micropost = current_user.microposts.build
     @feed_items =
       MicropostDecorator.decorate_collection(
         MicropostFeed.for(current_user).
           most_recent.paginate(page: params[:page])
       )
   end
  end

  def self.local_prefixes
    [controller_path]
  end
  private_class_method :local_prefixes
end
