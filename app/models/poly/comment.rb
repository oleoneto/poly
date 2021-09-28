# == Schema Information
#
# Table name: comments
#
#  id               :uuid              not null, primary key
#  commentable_type :string            not null
#  content          :text              not null
#  discarded_at     :datetime
#  is_private       :boolean           default(FALSE), not null
#  created_at       :datetime          not null
#  updated_at       :datetime          not null
#  commentable_id   :integer           not null
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
    include Poly::Concerns::Reactable
    include Poly::Concerns::Sortable
    include Poly::Concerns::Trashable
    include Poly::Concerns::UserOwned
    include Poly::Concerns::Visibility

    has_rich_text :content

    belongs_to :commentable, polymorphic: true

    validates :commentable, presence: true
    validates :content, presence: true
  end
end