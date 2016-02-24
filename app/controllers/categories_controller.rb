class CategoriesController < ApplicationController
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
  
  def show
  end
  
  private
  def category_params
    params.require(:category).permit(:name)
  end
end