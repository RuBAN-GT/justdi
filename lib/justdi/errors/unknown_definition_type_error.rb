# frozen_string_literal: true

module Justdi
  class UnknownDefinitionTypeError < StandardError
    def initialize(definition)
      super "Unknown definition type: #{definition.type}"
    end
  end
end
