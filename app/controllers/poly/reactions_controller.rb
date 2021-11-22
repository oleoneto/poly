require_dependency "poly/application_controller"

module Poly
  class ReactionsController < ApplicationController
    def create
      @reactable.reactions.where(user_id: current_user.id, kind: params[:kind]).first_or_create
      respond_to do |format|
        format.html { redirect_to @reactable }
        format.js
      end
    end

    def destroy
      @reactable.reactions.where(user_id: current_user.id, kind: params[:kind]).destroy_all
      respond_to do |format|
        format.html { redirect_to @reactable }
        format.js
      end
    end

    def reaction_params
      params.require(:reactable).permit(:kind)
    end
  end
end
