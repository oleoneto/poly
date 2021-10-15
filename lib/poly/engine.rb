module Poly
  class Engine < ::Rails::Engine
    isolate_namespace Poly

    config.generators do |generators|
      generators.test_framework :rspec
      generators.assets false
    end

    initializer "poly" do |app|
      app.config.assets.precompile << "poly/application.js"
      app.config.assets.precompile << "poly/application.css"
    end
  end

  # Do not prefix table names with `poly_`
  def self.table_name_prefix
  end
end
