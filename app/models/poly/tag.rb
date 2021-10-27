module Poly
  class Tag < ApplicationRecord
    has_many :taggings
  end
end
