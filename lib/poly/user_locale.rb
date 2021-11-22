module Poly
  module UserLocale
    def current_user
      @current_user ||= User.second
    end

    protected

    def set_user_locale
      I18n.locale = params[:locale] ||
        session[:locale] ||
        extract_locale_from_header ||
        I18n.default_locale
    end

    def extract_locale_from_header
      if request.headers['HTTP_ACCEPT_LANGUAGE']
        language = request.headers['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first.to_sym
        language.in?(Poly::supported_locales) ? language : nil
      end
    end
  end
end
