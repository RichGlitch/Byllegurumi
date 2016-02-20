class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  
  
  def index
    @articles = Article.all
  end
  
  def new
    @article = Article.new
  end
  
  
  def edit
  end
  
  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:info] = "Artículo actualizado."
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end
  
  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:success] = "Articulo ha sido creado exitosamente."
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end
  
  
  def show
  end
  
  def destroy
   # @article = Article.find(params[:id])
    @article.destroy
    
    flash[:danger] = "Articulo eliminado"
    redirect_to articles_path
  end
  
  private
  def set_article
    @article = Article.find(params[:id])
  end
  def article_params
    params.require(:article).permit(:titulo,:subtitulo, :patron)
  end
end