# == Schema Information
#
# Table name: trashes
#
#  id             :uuid             not null, primary key
#  trashable_type :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  trashable_id   :integer          not null
#  user_id        :uuid             not null
#
# Indexes
#
#  index_trashes_on_public_uid      (public_uid)
#  index_trashes_on_trashable_id    (trashable_id)
#  index_trashes_on_trashable_type  (trashable_type)
#  index_trashes_on_user_id         (user_id)
#  index_unique_trash_item          (user_id,trashable_id,trashable_type)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id) ON DELETE => cascade
#
module Poly
  class Trash < ApplicationRecord
    include Poly::Concerns::Sortable
    include Poly::Concerns::UserOwned

    belongs_to :trashable, polymorphic: true

    after_create :schedule_deletion
    after_destroy :destroy_parent unless :trashable.nil?

    # Stale records are those that have been in the trash for `T` amount of time
    scope :stale, -> { where("created_at <= ?", Time.zone.now - Poly::trash_ttl) }

    private

    # Schedule the deletion of this and parent record
    def schedule_deletion
      Poly::CleanTrashJob
        .set(wait_until: Poly::trash_ttl.from_now)
        .perform_later(self)
    end

    def destroy_parent
      trashable.destroy
    end

    def self.clean_stale!
      stale.destroy_all
    end

    def self.clean!
      destroy_all
    end
  end
end