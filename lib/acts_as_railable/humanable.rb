module ActsAsRailable
  module Humanable
    extend ActiveSupport::Concern

    module ClassMethods
      def i18n_attribute_name attr
        self.human_attribute_name attr
      end

      def i18n_action_name name, default_name=nil
        action_key = "#{self.table_name}.action.#{name}"
        default_key = "helper.action.#{name}" # unless I18n.exists? key
        default_name ||= name.to_s.capitalize
        I18n.t(action_key, model: self.model_name.human, default: [ default_key.to_sym, default_name ])
      end

      # i18n_enum_name(:status, :edited)
      def i18n_enum_name(enum_name, enum_value)
        self.human_attribute_name "#{enum_name}.#{enum_value}"
      end

      # enum status: { edited: 0, published: 1, approved: 2, trashed: 3 }
      # i18n_enum_choices(:status)
      def i18n_enum_choices enum_name
        enum_hash = self.public_send enum_name.to_s.pluralize
        enum_hash.keys.map { |enum_value| [ self.i18n_enum_name(enum_name, enum_value), enum_value ] }
      end

      # CURRENCIES = %w( CNY USD EUR GBP JPY )
      # i18n_array_choices(:currency)
      def i18n_array_choices enum_name
        array_values = self.const_get enum_name.to_s.pluralize.upcase
        array_values.map { |enum_value| [ self.i18n_enum_name(enum_name, enum_value), enum_value ] }
      end
    end

    def i18n_attribute_name attr
      self.class.human_attribute_name attr
    end

    def i18n_enum_name enum_name
      enum_value = self.public_send enum_name
      self.class.i18n_enum_name enum_name, enum_value
    end
  end
end
