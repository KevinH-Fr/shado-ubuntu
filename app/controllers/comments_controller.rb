class CommentsController < ApplicationController
    before_action :set_commentable

    def new
      @comment = Comment.new
    end

    def show
      @comment =  Comment.find(params[:id])
      mark_notifications_as_read
    end 
  
    def create
      @comment = @commentable.comments.build(comment_params)
      if @comment.save
        redirect_to @commentable unless @commentable.is_a?(Comment)
        redirect_to @commentable.find_top_parent if @commentable.is_a?(Comment)
        flash[:notice] = 'Comment created'
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    def destroy
      @comment = Comment.find(params[:id])
      if @comment.destroy
        redirect_to @commentable unless @commentable.is_a?(Comment)
        redirect_to @commentable.find_top_parent if @commentable.is_a?(Comment)
        flash[:notice] = 'Comment deleted'
      else
        redirect_to @commentable, alert: 'Something went wrong'
      end
    end

  
    private
  
    # not very nice, in my opinion
     def set_commentable

       if params[:post_id].present?
         @commentable = Post.find(params[:post_id])
       elsif params[:comment_id]
         @commentable = Comment.find(params[:comment_id])
       else
         "SOME ERROR"
       end
    end
  
    def comment_params
      params.require(:comment).permit(:body).merge(user: current_user)
    end

    def mark_notifications_as_read
      if current_user 
        comment = Comment.find(params[:id])
        notifications_to_mark_as_read = comment.notifications_as_comment.where(recipient: current_user)
        notifications_to_mark_as_read.update_all(read_at: Time.new)
      end
    end

  end