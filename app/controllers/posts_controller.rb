class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy upvote downvote vote]
  before_action :authorize_user

  def index
    @posts = Post.non_exclusif.order(created_at: :desc)
    @fan = Fan.find_by(user_id: current_user.id)
    @comment = Comment.new

    if @fan
      @athletes = @fan.athletes
      @posts_suivis = Post.where(athlete_id: @athletes.pluck(:id))
    else
      @posts_suivis = []
    end
  end

  def vote 

    @commentable = @post
    @comment = Comment.new
    @comments = @post.comments

    case params[:type]
    when 'upvote'
      if current_user
        @post.upvote!(current_user)
      else
        return redirect_to new_user_registration_path, alert: "Sign up first"
      end 
    when 'downvote'
      @post.downvote!(current_user)
    else 
      return redirect_to request.url, alert: "no such vote type"
    end

    respond_to do |format| 
      format.html do 
        redirect_to @post
      end
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(@post, 
          partial: "posts/post",
          locals: {post: @post })
      end
    end

  end 

  def show
    @commentable = @post
    @comment = Comment.new
    @comments = @post.comments
    mark_notifications_as_read
  end

  def upvote
    @post.upvote!(current_user)
    
  end

  def downvote
    @post.downvote!(current_user)
    
  end

  def new
    @post = Post.new
    @athlete = Athlete.where(user_id: current_user.id).first

    # tempo alternative athlete ou fan
    unless @athlete.present?
      @fan = Fan.where(user_id: current_user.id).first
    end

  end

  def edit
    @athlete = Athlete.where(user_id: current_user.id).first
  end

  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save

       # Trigger the notification
    #   PostNotification.with(post: @post).deliver_later(User.all)

        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :location, :content, :athlete_id, :exclusif, :media)
    end

    def mark_notifications_as_read
      if current_user 
        notifications_to_mark_as_read = @post.notifications_as_post.where(recipient: current_user)
        notifications_to_mark_as_read.update_all(read_at: Time.new)
      end
    end


    def authorize_user
      unless current_user 
        redirect_to new_user_registration_path, alert: "Sign up first"
      end
    end

end