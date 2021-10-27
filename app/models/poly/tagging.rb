module Poly
  class Tagging < ApplicationRecord
    belongs_to :tag, class_name: 'Poly::Tag'
    belongs_to :taggable, polymorphic: true
  end
end
