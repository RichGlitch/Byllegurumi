class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :destroy, :update]
  
  def index
    #@articles = Article.all.order("created_at").paginate(page: params[:page], per_page: 1)
    @articles = Article.paginate(page: params[:page], per_page: 10)
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
    @article.user =current_user
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
  def require_same_user
    if current_user != @article.user and !current_user.admin?
      flash[:danger] = "No puedes borrar este articulo"
      redirect_to root_path
    end
  end
end