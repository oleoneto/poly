module Poly
  module Concerns
    module Followable
      extend ActiveSupport::Concern

      included do
        has_many :follows, dependent: :destroy, class_name: "Poly::Follow"
        has_many :followers, foreign_key: 'followee_id', class_name: "Poly::Follow"

        scope :with_follows, -> { includes(:follows) }
        scope :with_followers, -> { includes(:followers) }
      end
    end
  end
end
