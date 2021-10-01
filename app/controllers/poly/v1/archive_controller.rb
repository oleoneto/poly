module Poly
  module V1
    class ArchiveController < Poly::ApiController
      def index
        @archives = current_user.archives.all
        render json: @archives, meta: { total: @archives.count, polymorphic: true }, status: 200
      end
    end
  end
end