# frozen_string_literal: true

module Poly
  module Concerns
    module Archiver
      # Archiver: an entity capable of creating and managing archives of other records.
      #
      extend ActiveSupport::Concern

      included do
        has_many :archives, dependent: :destroy
        scope :with_archives, -> { include(:archives) }
      end
    end
  end
end
