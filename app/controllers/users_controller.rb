class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :set_user, only: [:show, :edit, :update]
  before_action :active_user, only: :show
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users =
      UserDecorator.decorate_collection(
        User.active.paginate(page: params[:page])
      )
  end

  def show
    # NOTE: active_relationships needed for the current user
    # when showing the follow form, but not needed if the user page being
    # shown belongs to the current user.
    current_user(includes: :active_relationships) unless current_user?(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render "edit"
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private

  def set_user
    @user =
      UserDecorator.decorate(
        User.find_with_microposts(params[:id]),
        context: { page: params[:page] }
      )
  end

  def user_params
    params.require(:user).permit(
      :name, :email, :password, :password_confirmation
    )
  end

  def active_user
    redirect_to(root_url) unless @user&.activated?
  end

  # Confirms the correct user.
  def correct_user
    redirect_to(root_url) unless current_user?(@user)
  end

  # Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  def self.local_prefixes
    [controller_path]
  end
  private_class_method :local_prefixes
end
