module Poly
  class ArticleSerializer < ApplicationSerializer
    attributes :title, :status, :is_private, :excerpt, :language, :discarded_at
    belongs_to :author
  end
end
