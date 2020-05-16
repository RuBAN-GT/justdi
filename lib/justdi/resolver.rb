# frozen_string_literal: true

module Justdi
  module Resolver
    class << self
      # Resolve definition using container
      #
      # @param definition [Justdi::Definition]
      # @param container [Justdi::Container]
      # @return [*]
      def call(definition, container)
        send "#{definition.type}_value", definition.pure_value, container
      end

      def class_value(value, container)
        ClassResolver.call value, container
      end

      def static_value(value, _)
        value
      end

      def factory_value(value, container)
        FactoryResolver.call value, container
      end
    end
  end
end
