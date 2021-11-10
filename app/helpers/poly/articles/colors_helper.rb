module Poly
  module Articles::ColorsHelper
    def article_color(tag_list)
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
  end
end
