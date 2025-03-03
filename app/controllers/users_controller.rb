class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update, :edit]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(params[:id]), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers

  end

  def following
    @user = User.find(params[:id])
    @following = @user.following

  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

  def store_location
    session[:return_to] = request.referer if request.referer
  end
  def redirect_back_or_default
    redirect_to(session[:return_to] || root_path)
  end
end
