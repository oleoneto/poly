require_dependency "poly/application_controller"

module Poly
  class ArchivesController < ApplicationController
    before_action :set_archive, except: [:index]
    include Pagy::Backend

    def index
      @paginator, @archives = pagy(Poly::Archive.latest, items: 10)
      respond_to do |format|
        format.html
        format.rss { render :layout => false }
      end
    end

    private

    def set_archive
      @archive = Poly::Archive.find(params[:id])
    end
  end
end
