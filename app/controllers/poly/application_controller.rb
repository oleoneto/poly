require 'poly/user_locale'

module Poly
  class ApplicationController < ActionController::Base
    include Poly::UserLocale

    before_action :set_user_locale
  end
end
