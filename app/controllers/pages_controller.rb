class PagesController < ApplicationController
  before_action :render_home_page, if: -> { params[:id] == "home" }

  def show
    render params[:id]
  end

  private

  def render_home_page
    if logged_in?
      @micropost = current_user.microposts.build
      @feed_items =
        MicropostDecorator.decorate_collection(
          MicropostFeed.for(current_user).
            most_recent.paginate(page: params[:page])
        )
      render "logged_in_home"
    else
      render "logged_out_home"
    end
  end

  def self.local_prefixes
    [controller_path]
  end
  private_class_method :local_prefixes
end
