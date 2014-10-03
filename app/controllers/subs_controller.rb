class SubsController < ApplicationController
  before_filter :require_current_user, except: [:show, :index]

  def new
    @sub = current_user.subs.new
    render :new

  end

  def create
    @sub = current_user.subs.new(sub_params)

    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def index
    @subs = Sub.all
    render :index
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  def edit
    @sub = Sub.find(params[:id])
    if current_user.id == @sub.moderator_id
      render :edit
    else
      flash[:errors] = "You are not logged in as the owner of this sub."
      redirect_to sub_url(@sub)
    end
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def destroy
    @sub = Sub.find(params[:id])
    @sub.destroy
    redirect_to subs_url
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)

  end


end
