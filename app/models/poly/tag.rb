module Poly
  class Tag < ApplicationRecord
    include ActionText::Attachable

    has_many :taggings
  end
end
