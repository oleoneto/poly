# frozen_string_literal: true

module Poly
  module Concerns
    module Archivable
      extend ActiveSupport::Concern

      included do
        has_many :archives, as: :archivable, dependent: :destroy, class_name: "Poly::Archive"
      end
    end
  end
end
