class PostsController < ApplicationController

 before_filter :require_current_user, except: [:show]

  def new
    @post = Sub.find(params[:sub_id]).posts.new
    render :new
  end

  def create
    @post = Sub.find(params[:sub_id]).posts.new(post_params)
    @post.author_id = current_user.id
    if @post.save
      @post.sub_ids = params[:post][:sub_ids]
      redirect_to sub_url(@post.sub)
    else
      flash[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    render :show
  end

  def edit
    @post = Post.find(params[:id])
    if @post.author_id == current_user.id
      render :edit
    else
      flash[:errors] = "You are not the author of this post."
      redirect_to post_url(@post)
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to sub_url(@post.sub)
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :url)
  end

end
