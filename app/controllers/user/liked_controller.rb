class User::LikedController < ApplicationController
  before_action :require_current_user
  def show
    @posts = Post.where(id: UserLike.where(user_id: params[:id]).pluck(:post_id)).order(id: :desc)
    @user = User.where(id: params[:id])[0]
    @users = User.where(id: @posts.pluck(:user_id)) if @posts != []
    @likes = UserLike.where(post_id: @posts.pluck(:id)) if @posts != []
  end
end
