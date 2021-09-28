require "poly/version"
require "poly/engine"

module Poly
  mattr_accessor :trash_ttl
  mattr_accessor :supported_locales
  mattr_accessor :supported_reactions

  self.trash_ttl = 30.days
  self.supported_locales = [:en]
  self.supported_reactions = [:bookmark, :emoji, :favorite, :like, :save]

  class Engine < Rails::Engine
  end

  def self.setup
    yield self
  end
end
