class SessionsController < ApplicationController
  skip_before_filter :require_login
  
  def new
    if current_user
      redirect_to dashboard_url
    end  
  end

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to dashboard_url, notice: "Signed in!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to "/", notice: "Signed out!"
  end

  def failure
    redirect_to root_url, alert: "Authentication failed, please try again."
  end
end
