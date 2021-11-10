require_dependency "poly/application_controller"

module Poly
  class UsersController < ApplicationController
    before_action :set_user
    include Pagy::Backend

    def index
      @pagination, @users = pagy(User.all, items: 10)
    end

    def show
      @article_pagination, @articles = pagy(Poly::Article.kept.where(author: @user), items: 5)
      @comments = Poly::Comment.kept.where(user: @user).latest  #.last(5)
      @has_content = @comments.count > 0 || @articles.count > 0
    end

    def edit
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
      @page_title = @user.name
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:first_name, :last_name)
    end
  end
end
