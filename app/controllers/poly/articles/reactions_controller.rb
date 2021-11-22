module Poly
  class Articles::ReactionsController < Poly::ReactionsController
    before_action :set_reactable, only: [:create, :destroy]

    private

    def set_reactable
      @reactable = Article.find(params[:article_id])
    end
  end
end
