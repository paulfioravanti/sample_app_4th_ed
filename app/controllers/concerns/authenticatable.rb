module Authenticatable
  extend ActiveSupport::Concern

  included do
    helper_method(
      :log_in,
      :current_user,
      :logged_in?,
      :log_out,
      :current_user?
    )
  end

  private

  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end

  # Returns the current logged-in user (if any).
  def current_user(includes: nil)
    if (user_id = session[:user_id]).present?
      @current_user ||=
        UserDecorator.decorate(User.includes(includes).find(user_id))
    elsif (user_id = cookies.signed[:user_id]).present?
      user = User.includes(includes).find(user_id)
      if user.present? &&
        Password::Digest.matches_token?(
          user.remember_digest,
          cookies[:remember_token]
        )
        log_in user
        @current_user = UserDecorator.decorate(user)
      end
    end
  end

  # Returns true if the given user is the current user.
  def current_user?(user)
    user == current_user
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    current_user.present?
  end

  # Logs out the current user.
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # Remembers a user in a persistent session.
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # Forgets a persistent session.
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
