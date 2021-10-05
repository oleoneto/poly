module Poly
  class ArticlesController < ApplicationController
    before_action :set_article, only: [:show]
    include Pagy::Backend

    def index
      @paginator, @articles = pagy(Article.published.latest, items: 6)
      respond_to do |format|
        format.html
        format.rss { render :layout => false }
      end
    end

    def show
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
      @page_title = @article.title
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:author_id, :title, :content, :status)
    end
  end
end
