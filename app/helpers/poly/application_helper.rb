module Poly
  module ApplicationHelper
    include Pagy::Frontend

    def sign_in_path
      "#"
    end

    def is_logged_in?
      current_user if defined?(current_user)
      false
    end
  end
end
