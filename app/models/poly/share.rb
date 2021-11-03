# == Schema Information
#
# Table name: shares
#
#  id             :bigint           not null, primary key
#  discarded_at   :datetime
#  shareable_type :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  invitee_id     :bigint           not null
#  shareable_id   :integer          not null
#  user_id        :bigint           not null
#
# Indexes
#
#  index_shares_on_discarded_at    (discarded_at)
#  index_shares_on_invitee_id      (invitee_id)
#  index_shares_on_public_uid      (public_uid)
#  index_shares_on_shareable_id    (shareable_id)
#  index_shares_on_shareable_type  (shareable_type)
#  index_shares_on_user_id         (user_id)
#  index_unique_shares             (invitee_id,shareable_type,shareable_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (invitee_id => users.id) ON DELETE => cascade
#  fk_rails_...  (user_id => users.id) ON DELETE => cascade
#
module Poly
  class Share < ApplicationRecord
    include Poly::Concerns::Sortable
    include Poly::Concerns::Trashable
    include Poly::Concerns::UserOwned

    has_prefix_id :share

    validates :invitee, presence: true
    validate :circular_invite
    validate :record_ownership, if: :shareable

    belongs_to :invitee, class_name: 'User', foreign_key: 'invitee_id'
    belongs_to :shareable, polymorphic: true

    protected

    def record_ownership
      if shareable.user == nil || shareable.user != user
        errors.add "cannot share someone else's item"
      end
    end

    def circular_invite
      errors.add "cannot share to yourself" if user == invitee
    end
  end
end
