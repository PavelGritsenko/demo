class UsersController < ApplicationController
  def show
    @user = User.find(Post.find(params[:id])[:user_id])
  end

  def follow
    @user = User.find(Post.find(params[:id])[:user_id])
    current_user.followees << @user
    redirect_back(fallback_location: user_path(@user))
  end

  def unfollow
    @user = User.find(Post.find(params[:id])[:user_id])
    current_user.followed_users.find_by(followee_id: @user.id).destroy
    redirect_back(fallback_location: user_path(@user))
  end

  def followers
    @user = User.find(params[:user_id])
  end

  def followees
    @user = User.find(params[:user_id])
  end
end
