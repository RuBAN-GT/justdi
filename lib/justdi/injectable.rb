# frozen_string_literal: true

module Justdi
  # Dependencies configuration
  module Injectable
    # Set dependency
    #
    # @param token [String, Symbol, Numeric, Class]
    def dependency(token, **opts)
      module_dependencies[token] = opts.transform_keys(&:to_sym)
    end

    # Get all dependencies
    #
    # @return [Hash]
    def dependencies
      module_dependencies.clone.freeze
    end

    protected

    def module_dependencies
      @module_dependencies ||= {}
    end
  end
end
