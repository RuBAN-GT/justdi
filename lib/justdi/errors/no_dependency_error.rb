# frozen_string_literal: true

module Justdi
  class NoDependencyError < StandardError
    def initialize(token)
      super "Dependency #{token} is not defined"
    end
  end
end
