class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :logged_in?, :current_user

  def current_user
    user = User.find_by_session_token(session[:token])
    user.nil? ? nil : user
  end

  def logged_in?
    !!current_user
  end

  def log_in!(user)
    session[:token] = user.reset_session_token!
  end

  def log_out!
    current_user.reset_session_token!
    session[:token] = nil
  end

  def require_current_user
    unless logged_in?
      flash[:errors] = "Your not logged in"
      redirect_to new_session_url
    end
  end

  def require_no_user
    if logged_in?
      flash[:errors] = "You're already logged in"
      redirect_to user_url(current_user)
    end
  end


end
