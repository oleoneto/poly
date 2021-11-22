# require_dependency "poly/api_controller"

module Poly
  module Api
    class ArticlesController < ApiController
      # load_and_authorize_resource
      before_action :set_article, only: [:show, :update, :destroy]

      def index
        @articles = Poly::Article.accessible_by(current_ability)
        render json: @articles, meta: { total: @articles.count, polymorphic: true }, status: 200
      end

      def show
        if @article
          render json: @article, status: 200
        else
          render json: { message: I18n.t("controllers.errors.not_found") }, status: 404
        end
      end

      def update
        if @article.update(article_params)
          render json: @article, status: 202
        else
          render json: @article, status: 400
        end
      end

      def destroy
      end

      private

      def set_article
        @article = Poly::Article.find(params[:id])
      end

      def article_params
        params.require(:article).permit(:title, :content, :excerpt, :status, :is_private, :tag_list)
      end
    end
  end
end
