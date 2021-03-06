class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    @posts = if current_user && current_user.id == @user.id || current_user && FollowerFollowed.where(
      follower_id: current_user.id, followed_id: @user.id
    ) != []
               Post.where(user_id: @user.id)
             else
               Post.where(user_id: @user.id,
                          only_followers: false)
             end

    @users = User.where(id: @posts.pluck(:user_id)) if @posts != []
    @likes = UserLike.where(post_id: @posts.pluck(:id)) if @posts != []
    @followers = User.where(id: FollowerFollowed.where(followed_id: @user.id).pluck(:follower_id))
    @following = User.where(id: FollowerFollowed.where(follower_id: @user.id).pluck(:followed_id))
  end

  # GET /users/new
  def new
    if !current_user.nil?
      flash[:notice] = 'You are already registerd.'
      redirect_to root_path
    else
      @user = User.new
    end
  end

  # GET /users/1/edit
  def edit; end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome, #{@user.name}!"
      redirect_to root_path
    else
      generate_flash(@user)
      render :new
    end
    # respond_to do |format|
    #   if @user.save
    #     session[:user_id] = @user.id
    #     format.html { redirect_to @user, notice: "User was successfully created." }
    #     format.json { render :show, status: :created, location: @user }
    #   else
    #     format.html { render :new, status: :unprocessable_entity }
    #     format.json { render json: @user.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    session.delete(:user_id)
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = if params[:id] == 'destroy'
              User.find(current_user.id)
            else
              User.find(params[:id])
            end
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
