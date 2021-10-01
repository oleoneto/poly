module Poly
  class Engine < ::Rails::Engine
    isolate_namespace Poly

    config.generators do |generators|
      generators.test_framework :rspec
    end
  end
end
