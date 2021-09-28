require 'poly/user_locale'

module Poly
  class ApiController < ActionController::API
    include Poly::UserLocale

    before_action :ensure_authorization!
    before_action :set_user_locale

    def ensure_authorization!
      unless defined?(current_user) && !current_user.nil?
        render json: {message: I18n.t('controllers.errors.authentication_required')}, status: 401
      end
    end

    def method_not_allowed
      render json: {message: I18n.t('controllers.errors.method_not_allowed')}, status: 405
    end

    def respond_with_errors(object)
      render json: {errors: ErrorSerializer.serialize(object)}, status: :unprocessable_entity
    end

    rescue_from ActionController::ParameterMissing do |e|
      render json: { errors: e.to_s.humanize }, status: 400
    end

    rescue_from ActionController::RenderError, NameError, NoMethodError do |e|
      render json: { errors: I18n.t('controllers.errors.server_error'), details: e.to_s.humanize }, status: 500
    end

    rescue_from ActionController::RoutingError do |e|
      render json: { errors: I18n.t('controllers.errors.not_found'), details: e.to_s.humanize }, status: 404
    end
  end
end