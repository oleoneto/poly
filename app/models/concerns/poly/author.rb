module Poly
  module Author
    extend ActiveSupport::Concern

    included do
      has_many :articles, dependent: :destroy
      scope :with_articles, -> { include(:articles) }
    end
  end
end
