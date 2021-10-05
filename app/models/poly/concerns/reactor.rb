# frozen_string_literal: true

module Poly
  module Concerns
    module Reactor
      # Reactor: an entity capable of creating and managing reactions on records.
      #
      extend ActiveSupport::Concern

      included do
        has_many :reactions, dependent: :destroy, class_name: "Poly::Reaction"
        scope :with_reactions, -> { include(:reactions) }
      end
    end
  end
end
