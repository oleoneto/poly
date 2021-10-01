module Poly
  module V1
    class TrashController < Poly::ApiController
      def index
        @trash = current_user.trashes.all
        render json: @trash, meta: { total: @trash.count, polymorphic: true }, status: 200
      end
    end
  end
end