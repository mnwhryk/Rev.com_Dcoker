class Public::RelationshipsController < ApplicationController
  before_action :set_user, except: %i[follow follower]

  def follow
    @user = User.find(params[:id])
    @users = @user.followings.all
  end

  def follower
    @user = User.find(params[:id])
    @users = @user.followers.all
  end

  def create
    following = current_user.follow(@user)
    if following.save
      flash[:notice] = 'フォローしました'
      # redirect_back(fallback_location: root_path)
      render :create
    else
      flash.now[:notice] = 'フォローに失敗しました'
      # redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    following = current_user.unfollow(@user)
    if following.destroy
      flash[:notice] = 'フォローを解除しました'
      # redirect_back(fallback_location: root_path)
      render :destroy
    else
      flash.now[:notice] = 'フォロー解除に失敗しました'
      # redirect_back(fallback_location: root_path)
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:follow_id])
  end
end
