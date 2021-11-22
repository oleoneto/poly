module Poly
  module Api
    class ReactionsController < Poly::ApiController
      # Fetch reactions for `current_user` if no `@reactable` is specified
      before_action -> { @reactable = current_user unless @reactable }

      before_action :ensure_user_has_permission!, except: [:index, :create, :destroy]

      def index
        @reactions = @reactable.reactions.kept
        render json: @reactions, meta: { total: @reactions.count, polymorphic: true }, status: 200
      end

      def show
        @reaction = Poly::Reaction.kept.find(params[:id])

        # TODO: Improve user permission check
        unless @reaction.nil?
          if @reaction.reactable.public? || is_resource_author? || is_parent_owner?
            return render json: @reaction, status: 200
          end
        end

        render json: { message: I18n.t('controllers.errors.not_found') }, status: 404
      end

      def create
        @reaction = @reactable.reactions.where(user: current_user).first_or_create
        render json: @reaction, status: 201
      end

      def destroy
        @reactable.reactions.where(user: current_user).destroy_all if @reactable
        render json: {message: I18n.t('controllers.destroyed')}, status: 204
      end

      private

      def ensure_user_has_permission!
        if @reactable.nil? || @reactable.user != current_user && !@reactable.public?
          render json: {message: I18n.t("controllers.errors.not_found")}, status: 404
        end
      end

      def is_resource_author?
        current_user == @reaction.user
      end

      def is_parent_owner?
        current_user == @reaction.reactable.user
      end
    end
  end
end