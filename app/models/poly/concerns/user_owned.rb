# frozen_string_literal: true

module Poly
  module Concerns
    module UserOwned
      extend ActiveSupport::Concern

      included do
        belongs_to :user
        validates :user, presence: true

        scope :with_user, -> { includes(:user) }
      end
    end
  end
end
