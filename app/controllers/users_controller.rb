class UsersController < ApplicationController
  def new
  end

  def show
    @user = UserDecorator.decorate(User.find(params[:id]))
  end
end
