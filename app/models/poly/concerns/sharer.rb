# frozen_string_literal: true

module Poly
  module Concerns
    module Sharer
      # Sharer: an entity capable of granting and revoking record-level access to other users.
      #
      extend ActiveSupport::Concern

      included do
        has_many :shares, dependent: :destroy
        scope :with_shares, -> { include(:shares) }
      end
    end
  end
end
