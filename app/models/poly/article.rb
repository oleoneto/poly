# == Schema Information
#
# Table name: articles
#
#  id           :bigint           not null, primary key
#  discarded_at :datetime
#  is_private   :boolean          default(TRUE), not null
#  language     :string
#  excerpt      :string           not null
#  status       :string           not null
#  title        :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  author_id    :bigint           not null
#
# Indexes
#
#  index_articles_on_discarded_at  (discarded_at)
#  index_articles_on_is_private    (is_private)
#  index_articles_on_language      (language)
#  index_articles_on_public_uid    (public_uid)
#  index_articles_on_title         (title)
#  index_articles_on_author_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id) ON DELETE => cascade
#
module Poly
  class Article < ApplicationRecord
    include ActionText::Attachable
    include Concerns::Commentable
    include Concerns::Reactable
    include Concerns::Sortable
    include Concerns::Taggable
    include Concerns::Trashable
    include Concerns::Visibility

    has_rich_text :content
    has_prefix_id :art

    belongs_to :author, class_name: "User", dependent: :destroy
    alias :user :author # needed by trashable

    enum status: {unlisted: 0, published: 1}

    scope :published, -> { where(status: :published) }
    scope :unlisted, -> { where(status: :unlisted) }
    scope :with_author, -> { includes(:author) }

    validates :title, length: { minimum: 3, maximum: 50}
    validates :content, presence: true
    validates :status, inclusion: { in: statuses.keys }
    validates :excerpt, length: { minimum: 3, maximum: 144 }
  end
end
