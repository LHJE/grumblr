class User::DashboardController < ApplicationController
  before_action :require_current_user
  def show
    # This is also a complex looking one, but it's almost identical to the line in post_controller's new method.  The only difference is that instead of having all the hidden posts by users current_user follows AND *all* other posts, it just has the followed ones regardless of "only followers" status, and all the posts by the current_user, but not EVERY other post.

    @posts = Post.where(user_id: FollowerFollowed.where(follower_id: current_user.id).pluck(:followed_id)).or(Post.where(user_id: current_user.id)).order(id: :desc)
    if @posts != []
      @users = User.where(id: @posts.pluck(:user_id))
    end
  end
end
