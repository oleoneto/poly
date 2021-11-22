# frozen_string_literal: true

module Poly
  module Concerns
    # Stores soft deletes in an intermediary table
    #
    # Options:
    #
    #
    module Trashable
      extend ActiveSupport::Concern
      prepend Discard::Model

      included do
        has_many :trashes, as: :trashable, dependent: :destroy, class_name: "Poly::Trash"

        after_discard :trash!
        after_undiscard :untrash!
      end

      # Add record to trash
      def trash!
        Trash.create(user: self.user, trashable: self)
        self.discard if self.undiscarded?
      end

      # Remove record from trash
      def untrash!
        Trash.find_by(user: self.user, trashable: self).destroy!
      end

      module ClassMethods
        # Deletes all records marked as discarded (or in trash)
        def clean_trash!
          self.discarded.destroy_all
        end
      end
    end
  end
end
