require "bundler/setup"

APP_RAKEFILE = File.expand_path("sandbox/Rakefile", __dir__)
load "rails/tasks/engine.rake"

load "rails/tasks/statistics.rake"

require "bundler/gem_tasks"

require 'rspec/core/rake_task'

namespace :spec do

  desc 'Run unit specs'
  RSpec::Core::RakeTask.new(:units) do |t|
    t.pattern = 'spec/unit/**/*_spec.rb'
    t.rspec_opts = '--require spec_helper'
  end

  desc 'Run integration specs'
  RSpec::Core::RakeTask.new(:integrations) do |t|
    t.pattern = 'spec/integration/**/*_spec.rb'
    t.rspec_opts = '--require spec_helper'
  end

  desc 'Run feature specs'
  RSpec::Core::RakeTask.new(:features) do |t|
    t.pattern = 'spec/features/**/*_spec.rb'
    t.rspec_opts = '--require spec_helper'
  end

  desc 'Runs unit and feature specs'
  task all: [:units, :integrations, :features]
end