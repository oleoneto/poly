# == Schema Information
#
# Table name: follows
#
#  id           :bigint           not null, primary key
#  discarded_at :datetime
#  public_uid   :string(18)       not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  followee_id  :bigint           not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_follows_on_discarded_at  (discarded_at)
#  index_follows_on_followee_id   (followee_id)
#  index_follows_on_public_uid    (public_uid)
#  index_follows_on_user_id       (user_id)
#  index_unique_user_follow       (user_id,followee_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (followee_id => users.id) ON DELETE => cascade
#  fk_rails_...  (user_id => users.id) ON DELETE => cascade
#
module Poly
  class Follow < ApplicationRecord

    broadcasts_to -> (follow) { "follows" }

    include Poly::Concerns::Sortable
    include Poly::Concerns::Trashable
    include Poly::Concerns::UserOwned

    belongs_to :followee, class_name: 'User', foreign_key: 'followee_id'

    validates :followee, presence: true
    validate :prevent_following_itself!

    def follower_name
      user.name
    end

    def followee_name
      followee.name
    end

    private

    def prevent_following_itself!
      errors.add 'cannot follow yourself' if user == followee
    end
  end
end
