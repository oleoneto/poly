# require_dependency "poly/api_controller"

module Poly
  module Api
    class ArchivesController < ApiController
      # load_and_authorize_resource

      def index
        @archives = current_user.archives.all
        render json: @archives, meta: { total: @archives.count, polymorphic: true }, status: 200
      end
    end
  end
end