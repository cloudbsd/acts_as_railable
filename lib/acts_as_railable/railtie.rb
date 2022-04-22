require 'acts_as_railable/view_helpers'

module ActsAsRailable
  class Railtie < ::Rails::Railtie
    initializer "acts_as_railable.view_helpers" do
      ActiveSupport.on_load(:action_view) { include ActsAsRailable::ViewHelpers }
    end
  end
end
