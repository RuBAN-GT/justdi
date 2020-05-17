# frozen_string_literal: true

module Justdi
  # Generic container
  class Container
    class << self
      attr_writer :resolver, :store

      # @return [Module<Justdi::Resolver>]
      def resolver
        @resolver ||= Justdi::Resolver
      end

      # @return [Class<Justdi::Store>]
      def store
        @store ||= Justdi::Store
      end
    end

    # Container store
    # @return [Justdi::Store]
    def store
      @store ||= self.class.store.new
    end

    # Register any dependency declaration
    #
    # @param token [String, Symbol, Numeric, Class]
    # @return [Justdi::Core::RegisterHandler]
    def bind(token)
      Justdi::RegisterHandler.new { |value| store.set token, value }
    end

    # Register any dependency declaration with alternative syntax
    #
    # @param token [String, Symbol, Numeric, Class]
    # @param definition [Hash]
    # @option definition [Symbol] :type
    # @option definition [*] :value
    def register(token, definition)
      store.set token, Justdi::Definition.new(**definition)
    end

    # Check existence of dependency
    # @return [Boolean]
    def has?(token)
      store.has? token
    end

    # Load and resolve dependency
    #
    # @param token [String, Symbol, Numeric, Class]
    # @return [*]
    def get(token)
      store.get(token)&.resolve do |definition|
        self.class.resolver.call definition, self
      end
    end

    # Resolve dependency
    #
    # @param klass [Class]
    # @return [Object]
    def resolve(klass)
      self.class.resolver.class_value klass, self
    end
  end
end
