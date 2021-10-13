module Poly
  class Engine < ::Rails::Engine
    isolate_namespace Poly

    config.generators do |generators|
      generators.test_framework :rspec
      generators.assets false
    end
  end

  # Do not prefix table names with `poly_`
  def self.table_name_prefix
  end
end
