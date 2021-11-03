require_dependency "poly/application_controller"

module Poly
  class ArticlesController < ApplicationController
    before_action :set_article, except: [:index, :create, :new]
    include Pagy::Backend

    def index
      if params[:tag]
        @paginator, @articles = pagy(Poly::Article.tagged_with(params[:tag]), items: 8)
      else
        @paginator, @articles = pagy(Poly::Article.kept.published.latest, items: 8)
      end
      respond_to do |format|
        format.html
        format.rss { render :layout => false }
      end
    end

    def show
    end

    def new
      @article = Poly::Article.new
    end

    def edit
    end

    def create
      @article = Poly::Article.new(article_params.merge(author: current_user))
      if @article.save
        redirect_to @article
      else
        render :new
      end
    end

    def update
      if @article.update(article_params)
        render :show
      else
        render :edit
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Poly::Article.find(params[:id])
      @page_title = @article.title
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:author_id, :title, :content, :excerpt, :status, :is_private, :tag_list)
    end
  end
end
