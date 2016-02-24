class CategoriesController < ApplicationController
  before_action :require_admin, except: [:index, :show]
  
  def index
    @categories = Category.paginate(page: params[:page], per_page: 10)
  end
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Categoría creada correctamente"
      redirect_to categories_path
    else
    end
  end
  
  def edit 
    @category = Category.find(params[:id])
  end
  
  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:success] = "Correctamente actualizado."
      redirect_to category_path(category)
    else
      render 'edit'
    end
  end
  def show
    @category = Category.find(params[:id])
    @category_articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end
  
  private
  def category_params
    params.require(:category).permit(:name)
  end
  def require_admin
    if !logged_in? || (logged_in? and !current_user.admin?)
      flash[:danger] = "Solo administrador."
      redirect_to categories_path
    end
  end
end