module Poly
  class Tag < ApplicationRecord
    include ActionText::Attachable
    has_prefix_id :tag

    has_many :taggings
  end
end
