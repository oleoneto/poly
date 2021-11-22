# == Schema Information
#
# Table name: archives
#
#  id              :bigint           not null, primary key
#  archivable_type :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  archivable_id   :integer          not null
#  user_id         :uuid             not null
#
# Indexes
#
#  index_archives_on_public_uid       (public_uid)
#  index_archives_on_archivable_id    (archivable_id)
#  index_archives_on_archivable_type  (archivable_type)
#  index_archives_on_user_id          (user_id)
#  index_unique_archive_item          (user_id,archivable_id,archivable_type)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id) ON DELETE => cascade
#
module Poly
  class Archive < ApplicationRecord
    include Poly::Concerns::Sortable
    include Poly::Concerns::Trashable
    include Poly::Concerns::UserOwned

    has_prefix_id :arch

    belongs_to :archivable, polymorphic: true

    after_destroy :destroy_parent

    private

    def destroy_parent
      archivable.destroy
    end

    def self.clean!
      destroy_all
    end
  end
end