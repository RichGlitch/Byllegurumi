class PagesController < ApplicationController
  def home
    @articles = Article.all.limit(3).order("created_at desc")
  end

  def about
  end
end