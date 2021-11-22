# == Schema Information
#
# Table name: comments
#
#  id               :bigint            not null, primary key
#  content_hash     :text              not null
#  is_private       :boolean           default(FALSE), not null
#  discarded_at     :datetime
#  created_at       :datetime          not null
#  updated_at       :datetime          not null
#  commentable_id   :integer           not null
#  commentable_type :string            not null
#  user_id          :bigint            not null
#
# Indexes
#
#  index_comments_on_commentable_id    (commentable_id)
#  index_comments_on_commentable_type  (commentable_type)
#  index_comments_on_discarded_at      (discarded_at)
#  index_comments_on_user_id           (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id) ON DELETE => cascade
#
module Poly
  class Comment < ApplicationRecord
    include Poly::Concerns::Commentable
    include Poly::Concerns::ContentHashable
    include Poly::Concerns::Reactable
    include Poly::Concerns::Sortable
    include Poly::Concerns::Trashable
    include Poly::Concerns::UserOwned
    include Poly::Concerns::Visibility

    has_rich_text :content
    has_prefix_id :comm

    belongs_to :commentable, polymorphic: true

    validates :commentable, presence: true
    validates :content, presence: true
  end
end