require_dependency "poly/application_controller"

module Poly
  class MentionsController < ApplicationController
    def index
      @tags = Poly::Tag.all
      @users = User.all
      @articles = Poly::Article.all
    end

    def articles
      @articles = Poly::Article.all
      @tags = Poly::Tag.all
    end

    def people
      @users = User.all
    end

    def tags
      @tags = Poly::Tag.all
    end
  end
end
