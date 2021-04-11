class FollowerFollowedController < ApplicationController
  before_action :require_current_user

  def create
    FollowerFollowed.create!(follower_id: current_user.id, followed_id: params[:id])
    flash[:notice] = "You have followed #{User.where(id: params[:id])[0].name}!"
    redirect_to user_dashboard_path
  end

  def destroy
    require "pry"; binding.pry
    FollowerFollowed.where(follower_id: current_user.id, followed_id: params[:id]).destroy
    flash[:notice] = "You have unfollowed #{User.where(id: params[:id])[0].name}!"
    redirect_to user_dashboard_path
  end

end
