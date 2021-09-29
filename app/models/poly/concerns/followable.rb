module Poly
  module Concerns
    module Followable
      extend ActiveSupport::Concern

      included do
        has_many :follows, dependent: :destroy
        has_many :followers, class_name: 'Follow', foreign_key: 'followee_id'

        scope :with_follows, -> { includes(:follows) }
        scope :with_followers, -> { includes(:followers) }
      end
    end
  end
end
