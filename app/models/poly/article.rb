# == Schema Information
#
# Table name: articles
#
#  id           :bigint           not null, primary key
#  language     :string
#  excerpt      :string           not null
#  status       :string           not null
#  title        :string           not null
#  content_hash :string           not null
#  is_private   :boolean          default(TRUE), not null
#  discarded_at :datetime
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
    include Concerns::ContentHashable
    include Concerns::Reactable
    include Concerns::Sortable
    include Concerns::Taggable
    include Concerns::Trashable
    include Concerns::Visibility

    has_rich_text :content
    has_prefix_id :art

    broadcasts_to -> (article) { "articles" }, inserts_by: :prepend

    belongs_to :author, class_name: "User"
    alias :user :author # needed by trashable

    enum status: {unlisted: 0, published: 1}
    enum language: Hash[LanguageList::COMMON_LANGUAGES.map { |l| [l.name, l.iso_639_1] }]

    scope :published, -> { where(status: :published) }
    scope :with_author, -> { includes(:author) }

    validates :title, length: { minimum: 3, maximum: 50}
    validates :content, presence: true
    validates :status, inclusion: { in: statuses.keys }
    validates :language, inclusion: { in: languages.keys }
    validates :excerpt, length: { minimum: 3, maximum: 144 }

    def colors
      supported_tags = %w[
          business
          coding
          entertainment
          finances
          media
          movies
          programming
          sciences
          social-sciences
          sports
          tourism
          travel
          trips
      ]

      tag_list.split(',').each do |tag|
        return tag if supported_tags.include? tag.strip
      end

      'base'
    end

    def relative_creation_time
      ActionController::Base.helpers.distance_of_time_in_words(Time.now, created_at)
    end

    private

    # TODO:
    # Use activejob to save information about the content everytime the article is saved
  end
end
