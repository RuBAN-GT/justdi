# frozen_string_literal: true

module Justdi
  # Wrapper over pure container values
  class Definition
    CLASS   = :class
    STATIC  = :static
    FACTORY = :factory

    attr_reader :type, :pure_value, :value

    def initialize(params)
      @type        = params[:type]
      @pure_value  = params[:value]
      @is_resolved = false
    end

    def resolved?
      @is_resolved
    end

    # Get resolved value using generator
    #
    # @yield [self]
    # @return [*]
    def resolve
      return value if resolved?

      @is_resolved = true
      @value       = yield self
    end
  end
end
