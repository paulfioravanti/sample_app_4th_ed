class SessionsController < ApplicationController
  def new
  end

  def create
    if user = UserAuthenticator.authenticate(params[:session])
      log_in user
      redirect_to user
    else
      flash.now[:danger] = "Invalid email/password combination"
      render "new"
    end
  end

  def destroy

  end
end
