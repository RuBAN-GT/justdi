# frozen_string_literal: true

module Justdi
  # Simple store
  class Store
    # Get value by key
    #
    # @param key [String, Symbol, Numeric, Class]
    # @return [*]
    def get(key)
      store[key]
    end

    # Check if the key is presented
    #
    # @param key [String, Symbol, Numeric, Class]
    # @return [Boolean]
    def has?(key)
      store.key?(key)
    end

    # Set value
    #
    # @param key [String, Symbol, Numeric, Class]
    # @param value [*]
    def set(key, value)
      store[key] = value
    end

    # Return all key-value pairs
    #
    # @return [Hash]
    def all
      @store.clone.freeze
    end

    protected

    def store
      @store ||= {}
    end
  end
end
