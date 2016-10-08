class ApplicationController < ActionController::Base
  include Authenticatable

  protect_from_forgery with: :exception

  private

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def self.local_prefixes
    ["shared", "layouts", controller_path]
  end
  private_class_method :local_prefixes
end
