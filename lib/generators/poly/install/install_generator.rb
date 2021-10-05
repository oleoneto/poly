module Poly
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      def copy_poly_migrations
        # Copy all migrations, including ActionMailbox, ActionText, and ActiveStorage
        rails_command "railties:install:migrations", inline: true
      end
    end
  end
end