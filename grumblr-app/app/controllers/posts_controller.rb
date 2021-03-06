class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  # GET /posts or /posts.json
  def index
    if current_user
      if !Post.where(only_followers: true)[0].nil? && !FollowerFollowed.where(follower_id: current_user.id)[0].nil?
        # This one is a doosie.  It sorta starts in the middle and spirals out.  What we're trying to find here is all the public non-"Only Followers" posts as well as the posts that this user can see because they follow a user who has "Only Followers" posts.

        # So first we find the FollowerFollowed models that have the current_user's id in the follower_id column.
        # Then we pluck all the `followed_id`'s out, since those are the id's of the users this current_user is following.
        # These ids are used to find Posts, but only posts with the matching followed_id's that ALSO have `only_followers`set to true (although, I maybe don't need them to be the only the ones that are marked true come to think of it.  More testing is needed there).
        # Before ordering anything, we want to make sure that we still have all the public posts, so there's an `.or()` at the end getting all public ones.
        # Lastly, we order them in descending order so the newest ones come up first.
        @posts = Post.where(user_id:
                            FollowerFollowed.where(follower_id:
                               current_user.id).pluck(:followed_id)).or(
                                 Post.where(only_followers: false)
                               ).order(id: :desc)
      else
        @posts = Post.where(only_followers: false).order(id: :desc)
      end
    else
      @posts = Post.where(only_followers: false).order(id: :desc)
    end
    @users = User.where(id: @posts.pluck(:user_id)) if @posts != []
    @likes = UserLike.where(post_id: @posts.pluck(:id)) if @posts != []
  end

  # GET /posts/1 or /posts/1.json
  def show
    @user = User.where(id: @post.user_id)[0]
    @likes = UserLike.where(post_id: @post.id)
  end

  # GET /posts/new
  def new
    if current_user.nil?
      flash[:notice] = 'You need to be logged in to grumbl.'
      redirect_to root_path
    else
      @post = Post.new
    end
  end

  # GET /posts/1/edit
  def edit
    if current_user.nil?
      flash[:notice] = 'You need to be logged in to edit a grumbl.'
      redirect_to root_path
    elsif current_user.id != @post.user_id
      flash[:notice] = 'You need to be the original grumblr to edit a grumbl.'
      redirect_to root_path
    end
  end

  # POST /posts or /posts.json
  def create
    @post = if post_params[:only_followers].nil?
              Post.new(post_params.merge(user_id: current_user.id, only_followers: false))
            else
              Post.new(post_params.merge(user_id: current_user.id))
            end
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Grumbl was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Grumbl was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    if current_user.nil?
      flash[:notice] = 'You need to be logged in to destroy a grumbl.'
      redirect_to root_path
    elsif current_user.id != @post.user_id
      flash[:notice] = 'You need to be the original grumblr to destroy a grumbl.'
      redirect_to root_path
    else
      @post.destroy
      respond_to do |format|
        format.html { redirect_to posts_url, notice: 'Grumbl was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:content, :grass_tags, :only_followers, :user_id)
  end
end
