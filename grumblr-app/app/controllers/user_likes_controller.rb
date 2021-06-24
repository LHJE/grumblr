class UserLikesController < ApplicationController
  before_action :require_current_user

  def create
    UserLike.create!(user_id: current_user.id, post_id: params[:id])
    flash[:notice] = 'You have liked the grumbl!'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    UserLike.where(user_id: current_user.id, post_id: params[:id])[0].destroy
    flash[:notice] = 'You have unliked the grumbl!'
    redirect_back(fallback_location: root_path)
  end
end
