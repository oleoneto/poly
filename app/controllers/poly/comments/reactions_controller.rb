module Poly
  module V1
    class Comments::ReactionsController < Poly::V1::ReactionsController
      before_action :set_reactable

      private

      def set_reactable
        @reactable = Poly::Comment.kept.with_reactions.find(params[:comment_id])
      end
    end
  end
end