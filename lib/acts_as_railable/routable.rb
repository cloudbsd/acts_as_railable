module ActsAsRailable
  module Routable
    extend ActiveSupport::Concern

    included do
    end

    def self.polymorphic_path(record_or_hash_or_array, options = {})
      Rails.application.routes.url_helpers.polymorphic_path(record_or_hash_or_array, options)
    end

    def self.polymorphic_url(record_or_hash_or_array, options = {})
      Rails.application.routes.url_helpers.polymorphic_url(record_or_hash_or_array, options)
    end

    def self.record_action_path record_or_hash_or_array, record_self, action, options={}
      record_or_hash_or_array = Array(record_or_hash_or_array)
      record_or_hash_or_array << record_self if record_or_hash_or_array.exclude?(record_self)
      if action.present? && %w(index show).exclude?(action.to_s)
        options.merge!({action: action})
      end
      self.polymorphic_path record_or_hash_or_array, options
    end

    def self.record_action_url record_or_hash_or_array, record_self, action, options={}
      record_or_hash_or_array = Array(record_or_hash_or_array)
      record_or_hash_or_array << record_self if record_or_hash_or_array.exclude?(record_self)
      if action.present? && %w(index show).exclude?(action.to_s)
        options.merge!({action: action})
      end
      self.polymorphic_url record_or_hash_or_array, options
    end

    # class methods
    module ClassMethods
      def polymorphic_path(record_or_hash_or_array=[], options = {})
        ActsAsRailable::Routable.polymorphic_path(record_or_hash_or_array, options)
      end

      def polymorphic_url(record_or_hash_or_array, options = {})
        ActsAsRailable::Routable.polymorphic_path(record_or_hash_or_array, options)
      end

      def action_path action=nil, record_or_hash_or_array=[], options={}
        ActsAsRailable::Routable.record_action_path record_or_hash_or_array, self, action, options
      end

      def action_url action=nil, record_or_hash_or_array=[], options={}
        ActsAsRailable::Routable.record_action_url record_or_hash_or_array, self, action, options
      end
    end

    # instance methods
    def action_path action=nil, record_or_hash_or_array=[], options={}
      ActsAsRailable::Routable.record_action_path record_or_hash_or_array, self, action, options
    end

    def action_url action=nil, record_or_hash_or_array=[], options={}
      ActsAsRailable::Routable.record_action_url record_or_hash_or_array, self, action, options
    end
  end
end
