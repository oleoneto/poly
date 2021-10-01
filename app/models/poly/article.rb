# == Schema Information
#
# Table name: articles
#
#  id           :uuid             not null, primary key
#  discarded_at :datetime
#  is_private   :boolean          default(TRUE), not null
#  language     :string
#  title        :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :uuid             not null
#
# Indexes
#
#  index_articles_on_discarded_at  (discarded_at)
#  index_articles_on_is_private    (is_private)
#  index_articles_on_language      (language)
#  index_articles_on_public_uid    (public_uid)
#  index_articles_on_title         (title)
#  index_articles_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id) ON DELETE => cascade
#
module Poly
  class Article < ApplicationRecord
    include Poly::Concerns::Commentable
    include Poly::Concerns::Reactable
    include Poly::Concerns::Sortable
    include Poly::Concerns::Trashable
    include Poly::Concerns::UserOwned
    include Poly::Concerns::Visibility

    has_rich_text :content

    validates :title, length: { minimum: 3, maximum: 50}
    validates :content, presence: true
  end
end