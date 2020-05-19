# frozen_string_literal: true

module Justdi
  # Builder of any classes as pure or injectables
  module ClassResolver
    # Destinations enum
    module Destination
      DEFAULT = :initializer
      INITIALIZER = DEFAULT
      CLASS_METHOD = :class_method
      INSTANCE_METHOD = :method
    end

    class << self
      # Build class by resolving all dependencies
      #
      # @param klass [Class<T>]
      # @param container [Justdi::Container]
      # @return [T]
      #
      # @raise [Justdi::NoDependencyError]
      # @raise [Justdi::UnknownDestinationError]
      def call(klass, container)
        return klass.new unless klass.is_a? Justdi::Injectable

        safe_klass = Class.new(klass)
        klass_args = klass.dependencies.each_with_object({}) do |(token, metadata), hash|
          resolve_dependency(safe_klass, token, metadata, container, hash)
        end

        safe_klass.new(**klass_args)
      end

      protected

      def resolve_dependency(klass, token, metadata, container, hash)
        raise Justdi::NoDependencyError, token unless container.has?(token)

        resolve_destination(klass, token, metadata, container.get(token), hash)
      end

      def resolve_destination(klass, token, metadata, value, store)
        destination = metadata[:destination] || Destination::DEFAULT

        case destination
        when Destination::DEFAULT, Destination::INITIALIZER
          store[token] = value
        when Destination::INSTANCE_METHOD
          klass.define_method(token) { value }
        when Destination::CLASS_METHOD
          klass.define_singleton_method(token) { value }
        else
          raise Justdi::UnknownDestinationError(destination)
        end
      end
    end
  end
end
