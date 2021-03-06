# frozen_string_literal: true

module Justdi
  # Wrapper over typed definition resolvers
  module Resolver
    class << self
      # Resolve definition using container
      #
      # @param definition [Justdi::Definition]
      # @param container [Justdi::Container]
      # @return [*]
      #
      # @raise [Justdi::UnknownDefinitionTypeError]
      def call(definition, container)
        resolver_method = "#{definition.type}_value"
        unless respond_to? resolver_method
          raise Justdi::UnknownDefinitionTypeError, definition
        end

        send resolver_method, definition.pure_value, container
      end

      # Resolve class using container
      #
      # @param value [Class]
      # @param container [Justdi::Container]
      # @return [Object]
      def class_value(value, container)
        ClassResolver.call value, container
      end

      # Resolve a static value
      #
      # @param value [*]
      # @param container [Justdi::Container]
      # @return [*]
      def static_value(value, _)
        value
      end

      # Invoke factory injecting container
      #
      # @param factory [Proc]
      # @param container [Justdi::Container]
      # @return [*]
      def factory_value(factory, container)
        FactoryResolver.call factory, container
      end
    end
  end
end
