require_relative "lib/poly/version"

Gem::Specification.new do |spec|
  spec.name        = "poly"
  spec.version     = Poly::VERSION
  spec.authors     = ["Leo Neto"]
  spec.email       = ["leo@ekletik.com"]
  spec.homepage    = "https://github.com/oleoneto/poly"
  spec.summary     = "An assortment of generic features"
  spec.license     = "MIT"
  spec.required_ruby_version = ">= 2.5.0"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/oleoneto/poly/blob/master/CHANGELOG.md"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.1.4", ">= 6.1.4.1"
  spec.add_dependency "discard", "~> 1.2"
  spec.add_dependency "jbuilder", "~> 2.7"
  spec.add_dependency "hotwire-rails"
  spec.add_dependency "pagy", "~> 4.8"
  spec.add_dependency "prefixed_ids", "~> 1.2"
  spec.add_dependency "apipie-rails", "~> 0.5"
  spec.add_dependency "image_processing", "~> 1.2"
  spec.add_dependency "cancancan", "~> 3.3"
  spec.add_dependency "active_model_serializers", "~> 0.10"
  spec.add_dependency "language_list", "~> 1.2.1"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "annotate"
  spec.add_development_dependency "sass-rails"
  spec.add_development_dependency "cssbundling-rails"
  spec.add_development_dependency "jsbundling-rails"
  spec.add_development_dependency "database_cleaner"
  spec.add_development_dependency "sidekiq"
end
