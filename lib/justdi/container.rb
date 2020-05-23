# frozen_string_literal: true

require 'forwardable'

module Justdi
  # Generic container
  class Container
    extend Forwardable

    def_delegators :store, :register, :has?, :set, :[], :[]=

    class << self
      attr_writer :resolver, :store

      # @return [Module<Justdi::Resolver>]
      def resolver
        @resolver ||= Justdi::Resolver
      end

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

    # Resolve dependency
    #
    # @param klass [Class<T>]
    # @return [T]
    def resolve(klass)
      self.class.resolver.class_value(klass, self)
    end

    # Merge containers
    #
    # @param container [Container]
    def merge(container)
      store.merge container.store
    end

    # Definition store
    # @return [Justdi::DefinitionStore]
    def store
      @store ||= self.class.store.new
    end
  end
end
