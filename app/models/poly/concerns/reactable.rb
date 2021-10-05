# frozen_string_literal: true

module Poly
  module Concerns
    module Reactable
      extend ActiveSupport::Concern
      prepend Discard::Model

      included do
        has_many :reactions, as: :reactable, dependent: :destroy, class_name: "Poly:Reaction"

        scope :with_reactions, -> { include(:reactions) }

        scope :bookmarks, -> { where(type: :bookmark) }
        scope :emoji, -> { where(type: :emoji) }
        scope :favorites, -> { where(type: :favorite) }
        scope :likes, -> { where(type: :like) }
        scope :saves, -> { where(type: :save) }

        after_discard -> { reactions.discard_all }
        after_undiscard -> { reactions.undiscard_all }
      end
    end
  end
end
