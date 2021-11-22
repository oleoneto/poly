module Poly
  module Concerns
    module Blogger
      extend ActiveSupport::Concern

      included do
        has_many :articles, class_name: 'Poly::Article', foreign_key: :author_id
      end
    end
  end
end
