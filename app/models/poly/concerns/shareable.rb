# frozen_string_literal: true

module Poly
  module Concerns
    module Shareable
      extend ActiveSupport::Concern

      included do
        has_many :shares, as: :shareable, dependent: :destroy, class_name: "Poly::Share"
      end
    end
  end
end
