class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = UserDecorator.decorate(User.find(params[:id]))
  end
end
