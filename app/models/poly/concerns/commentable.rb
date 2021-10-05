# frozen_string_literal: true

module Poly
  module Concerns
    module Commentable
        extend ActiveSupport::Concern
        prepend Discard::Model

        included do
          has_many :comments, as: :commentable, dependent: :destroy, class_name: "Poly::Comment"

          scope :commented, -> { where(comments.count > 0) }
          scope :with_comments, -> { includes(:comments) }

          after_discard -> { comments.discard_all }
          after_undiscard -> { comments.undiscard_all }
        end
    end
  end
end
