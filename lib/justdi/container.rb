# frozen_string_literal: true

require 'forwardable'

module Justdi
  # Generic container
  class Container
    extend Forwardable

    def_delegators :store, :register, :has?, :empty?, :set, :[]=

    class << self
      attr_writer :resolver, :store

      # Resolver module
      # @return [Module<Justdi::Resolver>]
      def resolver
        @resolver ||= Justdi::Resolver
      end

      # Class for generation
      # @return [Class<Justdi::DefinitionStore>]
      def store
        @store ||= Justdi::DefinitionStore
      end
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

    # Short getting syntax
    # @param token [String, Symbol, Numeric, Class]
    # @return [*]
    def [](token)
      get(token)
    end

    # Resolve dependency
    #
    # @param klass [Class<T>]
    # @return [T]
    def resolve(klass)
      self.class.resolver.class_value(klass, self)
    end

    # Merge containers
    #
    # @param container [Justdi::Container]
    def merge(container)
      store.merge container.store
    end

    # Import definition store
    #
    # @param def_store [Justdi::DefinitionStore]
    # @param overwrite [Boolean]
    def import_store(def_store, overwrite: true)
      return store.merge(def_store) if overwrite

      def_store.each do |key, value|
        store.set(key, value) unless store.has?(key)
      end
    end

    protected

    # Definition store
    # @return [Justdi::DefinitionStore]
    def store
      @store ||= self.class.store.new
    end
  end
end
