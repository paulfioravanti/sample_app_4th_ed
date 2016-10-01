class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if valid_new_user?(user)
      user.activate
      log_in(user)
      flash[:success] = "Account activated!"
      redirect_to user
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end

  private

  def valid_new_user?(user)
    user.present? &&
      !user.activated? &&
        Password::Digest.matches_token?(user.activation_digest, params[:id])
  end
end
