module Poly
  module Concerns
    # Handles record verification. Use cases include user verification badge for social platforms.
    #
    # Options:
    #
    # - :verification_column - The column used to track record verification. Defaults to `:is_verified`.
    module Verifiable
      extend ActiveSupport::Concern

      included do
        class_attribute :verification_column
        self.verification_column = :is_verified
      end

      def verify
        return unless unverified?
        update_attribute(self[self.class.verification_column], true)
      end

      def unverify
        return unless verified?
        update_attribute(self[self.class.verification_column], false)
      end

      def verified?
        [self.class.verification_column] == true
      end

      def unverified?
        !verified?
      end
    end
  end
end
