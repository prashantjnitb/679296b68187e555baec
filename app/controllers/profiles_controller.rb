class ProfilesController < ApplicationController
  before_action :load_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.includes(:followed).where.not(id: current_user.id)
  end

  def show
  end

  def unfollow
    Follow.find_by(follower_id: current_user.id, following_id: params[:id]).destroy
    flash[:notice] = "Unfollowed successfully"
    if request.env["HTTP_REFERER"].present? and request.env["HTTP_REFERER"] != request.env["REQUEST_URI"]
      redirect_to request.env["HTTP_REFERER"]
    else
      redirect_to profile_path(current_user)
    end
  end

  def follow
    follow = Follow.find_or_initialize_by(follower_id: current_user.id, following_id: params[:id])
    if follow.persisted?
      flash[:notice] = "Already following"
    else
      flash[:notice] = "Unfollowed successfully"
      follow.save
    end
    if request.env["HTTP_REFERER"].present? and request.env["HTTP_REFERER"] != request.env["REQUEST_URI"]
      redirect_to request.env["HTTP_REFERER"]
    else
      redirect_to profiles_path
    end
  end

  private

    def load_user
      @user = User.find(params[:id])
    end

end
