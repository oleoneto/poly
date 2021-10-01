module Poly
  module V1
    class CommentsController < Poly::ApiController
      # Fetch comments for `current_user` if no `@commentable` is specified
      before_action -> { @commentable = current_user unless @commentable }

      before_action :ensure_user_has_permission!, except: [:index, :create, :destroy]

      def index
        @comments = @commentable.comments.kept.latest
        render json: @comments, meta: { total: @comments.count, polymorphic: true }, status: 200
      end

      def show
        @comment = Comment.kept.find(params[:id])

        # TODO: Improve user permission check
        unless @comment.nil?
          if @comment.commentable.public? || is_comment_author? || is_commentable_owner?
            return render json: @comment, status: 200
          end
        end

        render json: { message: I18n.t('controllers.errors.not_found') }, status: 404
      end

      def create
        @comment = @commentable.comments.new(comment_params)
        @comment.user = current_user
        @comment.save

        render json: @comment, status: 201
      end

      def destroy
        @comment = Comment.find(params[:id])

        if @comment.nil?
          return render json: {message: I18n.t('controllers.errors.not_found')}, status: 404
        end

        # TODO: Improve user permission check
        if is_resource_author? || is_parent_owner?
          @comment.destroy
          return render json: {message: I18n.t('controllers.destroyed')}, status: 204
        end

        render json: {message: I18n.t('controllers.errors.not_authorized') }, status: 403
      end

      private

      def ensure_user_has_permission!
        if @commentable.nil? || @commentable.user != current_user && !@commentable.public?
          render json: {message: I18n.t("controllers.errors.not_found")}, status: 404
        end
      end

      def is_resource_author?
        current_user == @comment.user
      end

      def is_parent_owner?
        current_user == @comment.commentable.user
      end

      def comment_params
        params.require(:comment).permit(:content)
      end
    end
  end
end