# frozen_string_literal: true

module Justdi
  module FactoryResolver
    class << self
      # Build value from factory
      #
      # @param factory [Proc]
      # @param container [Justdi::Container]
      # @return [*]
      def call(factory, container)
        factory.call container
      end
    end
  end
end
