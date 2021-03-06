# == Schema Information
#
# Table name: reactions
#
#  id                :bigint           not null, primary key
#  discarded_at      :datetime
#  is_private        :boolean          default(TRUE), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  reactable_type    :string           not null
#  reactable_id      :integer          not null
#  kind              :string           not null
#  user_id           :bigint           not null
#
# Indexes
#
#  index_reactions_on_reactable_id      (reactable_id)
#  index_reactions_on_reactable_type    (reactable_type)
#  index_reactions_on_discarded_at      (discarded_at)
#  index_reactions_on_is_private        (is_private)
#  index_reactions_on_public_uid        (public_uid)
#  index_reactions_on_user_id           (user_id)
#  index_reactions_on_kind              (kind)
#  index_unique_reactions               (user_id,type,reactable_type,reactable_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id) ON DELETE => cascade
#
module Poly
  class Reaction < ApplicationRecord
    include Poly::Concerns::Sortable
    include Poly::Concerns::Trashable
    include Poly::Concerns::UserOwned
    include Poly::Concerns::Visibility

    belongs_to :reactable, polymorphic: true, dependent: :destroy

    enum kind: {
      bookmark: 10,
      save: 11,
      favorite: 12,
      like: 13,
      emoji: 20,
    }, _prefix: :reaction

    validate :emoji_type_has_data!

    def emoji_type_has_data!
      errors.add "emoji missing" if reaction_emoji? && data.nil?
    end
  end
end
