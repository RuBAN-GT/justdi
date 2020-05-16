# frozen_string_literal: true

module Justdi
  module ClassResolver
    class << self
      # Build class by resolving all dependencies
      #
      # @param klass [Class]
      # @param container [Justdi::Container]
      # @return [Class]
      def call(klass, container)
        return klass.new unless klass.is_a? Justdi::Injectable

        klass_args = klass.dependencies.each_with_object({}) do |(token, _), hash|
          raise Justdi::NoDependencyError, token unless container.has?(token)

          hash[token] = container.get(token)
        end
        klass.new klass_args
      end
    end
  end
end
