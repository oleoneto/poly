module Poly
  module ApplicationHelper
    include Pagy::Frontend
    include UserLocale

    def supported_themes
      %w[light dark alternative]
    end
  end
end
