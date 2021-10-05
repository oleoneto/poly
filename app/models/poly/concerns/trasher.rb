# frozen_string_literal: true

module Poly
  module Concerns
    module Trasher
      # Trasher: an entity that owns and manages records that can be added to trash.
      #
      extend ActiveSupport::Concern

      included do
        has_many :trashes, dependent: :destroy, class_name: "Poly::Trash"
        scope :with_trash, -> { include(:trashes) }
      end
    end
  end
end
