module Poly
  module ApplicationHelper
    include Pagy::Frontend
    include UserLocale

    def supported_themes
      %w[light dark alternative]
    end

    def sign_in_path
      "#"
    end

    def is_logged_in?
      return current_user if defined?(current_user)
      false
    end

    def is_author?(user)
      if is_logged_in?
        current_user == user
      else
        false
      end
    end
  end
end
