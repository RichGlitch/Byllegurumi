class SessionsController < ApplicationController
  def new
    if logged_in?
      flash[:info] = "Ya estás logueado como #{current_user.username}"
      redirect_to root_path
    end
  end
  
  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "Exito en login"
      redirect_to user_path(user)
    else
      flash.now[:danger] = "Hubo algo mal con la información "
      render 'new'
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:success] = "Logged out"
    redirect_to root_path
  end
end