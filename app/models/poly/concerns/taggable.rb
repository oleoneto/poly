module Poly
  module Concerns
    module Taggable
      extend ActiveSupport::Concern

      included do
        attr_accessor :name, :tag_list

        has_many :taggings, as: :taggable, class_name: 'Poly::Tagging'
        has_many :tags, through: :taggings, class_name: 'Poly::Tag'

        scope :with_tags, -> { include(:tags) }

        def self.tag_counts
          Poly::Tag.select("tags.*, count(taggings.tag_id) as count").joins(:taggings).group("taggings.tag_id", "tags.id")
        end

        def tag_list
          tags.map(&:name).join(", ")
        end

        def tag_list=(names)
          self.tags = names.split(",").map do |name|
            tag = name.downcase.strip
            Poly::Tag.where(name: tag).first_or_create! if tag.length >= 3
          end.compact
        end
      end

      module ClassMethods
        def tagged_with(name)
          self.joins(:tags).where(:tags => {:name => name})
        end
      end
    end
  end
end
