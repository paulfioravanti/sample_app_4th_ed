class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = UserDecorator.decorate(User.find(params[:id]))
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # Handle a successful save.
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name, :email, :password, :password_confirmation
    )
  end

  def self.local_prefixes
    [controller_path]
  end
  private_class_method :local_prefixes
end
