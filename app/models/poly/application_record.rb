module Poly
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
    self.implicit_order_column = "created_at"
    default_scope -> { order("created_at ASC") }
  end
end
