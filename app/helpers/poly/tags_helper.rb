module Poly
  module TagsHelper
    def tag_cloud(collection, classes)
      tags = collection.tag_counts(collection.pluck(:id))

      max = tags.sort_by(&:count).last
      tags.each do |tag|
        index = tag.count.to_f / max.count * (classes.size - 1)
        yield(tag, classes[index.round])
      end
    end
  end
end
