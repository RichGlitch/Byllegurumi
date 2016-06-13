class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]
  
  def new
    #redirect_to root_path #para que no haya signup. solo usuarios controlados.
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to the blog #{@user.username}"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def index
    @users = User.all
  end

  def update
    if @user.update(user_params)
      flash[:success] = ' #{@user.username} updated'
      redirect_to articles_path
    else
      render 'edit'
    end
  end
  
  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end
  
  def destroy
    @user = User.find(params[:id])  
    @user.destroy
     flash[:danger] = "Usuario y articulos borrados"
     redirect_to users_path
  end
  
  
  private
  def set_user
    @user = User.find(params[:id])
  end
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
  def require_same_user
    if !logged_in? || current_user != @user and !current_user.admin?
      flash[:danger] = "No puedes acceder a esta parte"
      redirect_to root_path
    end
  end
  def require_admin
    if !logged_in? and !current_user.admin?
      flash[:danger] = "No puedes acceder a esta parte"
      redirect_to root_path
    end
  end
end