require_dependency "poly/application_controller"

module Poly
  class SettingsController < ApplicationController
    def index
    end

    def update
      @current_user ||= params[:user]
    end

    def current_user
      super
    end

    protected

    def settings_params
      params.require(:settings).permit(:user)
    end
  end
end
