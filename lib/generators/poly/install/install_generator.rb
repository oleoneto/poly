module Poly
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      def copy_poly_migrations
        # Copy all migrations, including ActionMailbox, ActionText, and ActiveStorage
        rails_command "railties:install:migrations FROM=poly", inline: true
      end

      def create_ams
        # Return JSON based on the JSON::API spec
        initializer "active_model_serializers.rb" do
          "ActiveModelSerializers.config.adapter = :json_api"
        end
      end

      def register_route
        route "mount Poly::Engine => '/poly'"
      end

      def register_allowed_attributes
        application do
          "
          config.after_initialize do
            ActionText::ContentHelper.allowed_attributes.add 'style'
            ActionText::ContentHelper.allowed_attributes.add 'controls'
            ActionText::ContentHelper.allowed_attributes.add 'poster'

            ActionText::ContentHelper.allowed_tags.add 'video'
            ActionText::ContentHelper.allowed_tags.add 'audio'
            ActionText::ContentHelper.allowed_tags.add 'source'
            ActionText::ContentHelper.allowed_tags.add 'embed'
            ActionText::ContentHelper.allowed_tags.add 'iframe'
          end

          "
        end
      end

      def register_sanitization_rules
        initializer "html_sanitization.rb" do
          "
          Rails::Html::WhiteListSanitizer.allowed_tags.merge(
            %w[
               audio controls button circle div video path source svg source
               id data-action data-controller data-target data-title data-src
            ]
          )"
        end
      end
    end
  end
end
