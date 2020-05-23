# frozen_string_literal: true

module Justdi
  # Store of entities definitions
  class DefinitionStore
    class << self
      attr_writer :general_store, :register_handler

      # Class for stores generation
      # @return [Class<Hash>]
      def general_store
        @general_store ||= Hash
      end

      # Class for register handlers generation
      # @return [Class<Justdi::RegisterHandler>]
      def register_handler
        @register_handler ||= Justdi::RegisterHandler
      end
    end

    # Register definition declaration
    #
    # @example Register a static value
    #   "container.register(:example).use_value(42)"
    #
    # @param token [String, Symbol, Numeric, Class]
    # @return [Justdi::RegisterHandler]
    def register(token)
      self.class.register_handler.new { |value| store[token] = value }
    end

    # Register any dependency declaration with alternative syntax
    #
    # @param token [String, Symbol, Numeric, Class]
    # @param definition [Hash]
    # @option definition [Symbol] :type
    # @option definition [*] :value
    def set(token, **definition)
      store[token] = Justdi::Definition.new(**definition)
    end

    # Short definition syntax
    # @param token [String, Symbol, Numeric, Class]
    # @param definition [Hash]
    def []=(token, definition)
      set(token, **definition)
    end

    # Check existence of dependency
    # @return [Boolean]
    def has?(token)
      store.key? token
    end

    # Store is empty
    # @return [Boolean]
    def empty?
      store.empty?
    end

    # Load dependency
    #
    # @param token [String, Symbol, Numeric, Class]
    # @return [*]
    def get(token)
      store[token]
    end

    # Short getting syntax
    # @param token [String, Symbol, Numeric, Class]
    # @return [*]
    def [](token)
      get(token)
    end

    # Merge definition stores
    #
    # @param def_store [DefinitionStore]
    def merge(def_store)
      @store = store.merge def_store.all
    end

    # Return all definitions
    # @return [Hash]
    def all
      store.clone.freeze
    end

    # Iterates over existing values
    #
    # @yield [token, definition]
    def each
      store.each { |(key, value)| yield key, value }
    end

    protected

    # Definition store
    # @return [Hash]
    def store
      @store ||= self.class.general_store.new
    end
  end
end
