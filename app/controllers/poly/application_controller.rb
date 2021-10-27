module Poly
  class ApplicationController < ActionController::Base
    include UserLocale

    before_action :set_user_locale
    before_action :set_page_title

    def set_page_title
      @page_title = controller_name.capitalize
    end
  end
end
