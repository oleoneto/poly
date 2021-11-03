require_dependency "poly/application_controller"

module Poly
  class AutocompleteController < ApplicationController
    before_action :force_json

    def articles
      @articles = Poly::Article.all
    end

    def users
      @users = User.all
    end

    def tags
      @tags = Poly::Tag.all
    end

    protected

    def force_json
      request.format = :json
    end
  end
end
