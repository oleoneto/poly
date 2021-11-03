require_dependency "poly/application_controller"

module Poly
  class TrashController < ApplicationController
    before_action :set_trash
    include Pagy::Backend

    def index
      respond_to do |format|
        format.html
        format.rss { render :layout => false }
      end
    end

    private

    def set_trash
      @paginator, @trash = pagy(Poly::Trash.latest, items: 8)
    end
  end
end
