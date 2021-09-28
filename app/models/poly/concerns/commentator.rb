# frozen_string_literal: true

module Poly
  module Concerns
    module Commentator
      # Commentator: an entity capable of creating and managing comments.
      #
      extend ActiveSupport::Concern

      included do
        has_many :comments, dependent: :destroy

        scope :with_comments, -> { includes(:comments) }
      end
    end
  end
end
