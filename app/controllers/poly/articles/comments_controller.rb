module Poly
  class Articles::CommentsController < Poly::CommentsController
    before_action :set_commentable, only: :create

    private

    def set_commentable
      @commentable = Article.find(params[:article_id])
    end
  end
end
