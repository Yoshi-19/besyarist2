class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      remember user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to user
    else
      flash.now[:danger] = 'emailまたはpasswordが正しくありません' # 本当は正しくない
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to static_pages_home_path
  end
end
