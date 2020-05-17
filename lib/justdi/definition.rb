# frozen_string_literal: true

module Justdi
  # Wrapper over pure container values
  class Definition
    CLASS   = :class
    STATIC  = :static
    FACTORY = :factory

    attr_reader :type, :pure_value, :value

    # @param type [Symbol]
    # @param value [*]
    def initialize(type:, value:)
      @type        = type
      @pure_value  = value
      @is_resolved = false
    end

    # Definition value is resolved
    #
    # @return [Boolean]
    def resolved?
      @is_resolved
    end

    # Get resolved value using generator
    #
    # @yield [self] generating resolved value
    # @return [*]
    def resolve
      return value if resolved?

      @is_resolved = true
      @value       = yield self
    end
  end
end
