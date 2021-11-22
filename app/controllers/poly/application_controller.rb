module Poly
  class ApplicationController < ActionController::Base
    include UserLocale

    before_action :set_user_locale
    before_action :set_page_title

    def set_page_title
      @page_title = controller_name.capitalize
    end

    rescue_from CanCan::AccessDenied do |exception|
      respond_to do |format|
        format.json { head :forbidden }
        format.html { redirect_back fallback_location: '/', flash: { error: exception.message } }
      end
    end
  end
end
