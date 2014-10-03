class CommentsController < ApplicationController

  def new
    @comment = Post.find(params[:post_id]).comments.new
    render :new
  end

  def create
    @comment = Post.find(params[:post_id]).comments.new(comment_params)
    @comment.author_id = current_user.id
    if @comment.save

      redirect_to post_url(@comment.post_id)
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
