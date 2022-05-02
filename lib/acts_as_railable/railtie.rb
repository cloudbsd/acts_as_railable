require 'acts_as_railable/view_helpers'
require "rails"

module ActsAsRailable
  class Railtie < ::Rails::Railtie
    initializer "acts_as_railable" do |app|
      ActiveSupport.on_load(:action_view) { include ActsAsRailable::ViewHelpers }

      ActsAsRailable::Railtie.instance_eval do
        pattern = pattern_from app.config.i18n.available_locales
        add("rails/locales/#{pattern}.yml")
      end
    end

    protected

    def self.add(pattern)
      files = Dir[File.join(File.dirname(__FILE__), "../..", pattern)]

      I18n.load_path.concat(files)
    end

    def self.pattern_from(args)
      array = Array(args || [])
      array.blank? ? "*" : "{#{array.join ','}}"
    end
  end
end

