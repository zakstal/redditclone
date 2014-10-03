class SessionsController < ApplicationController

  before_filter :require_no_user, only: [:new, :create]
  before_filter :require_current_user, only: [:destroy]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(user_params)

    if @user.save
      log_in!(@user)
      redirect_to subs_url
    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def destroy
    log_out!
    redirect_to new_session_url
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
